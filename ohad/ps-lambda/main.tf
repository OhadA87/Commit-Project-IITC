
resource "aws_lambda_function" "parameter_store_lambda" {
  filename         = "${var.lambda_function_code_path}" 
  function_name    = "${var.function_name}"
  role             = aws_iam_role.parameter_store_message_lambda.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
 source_code_hash = filebase64sha256("./ps_lambda_package.zip") 

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = var.dynamodb_table_name
      PARAMETER_NAME      = var.parameter_store_parameter_name 
    }
  }

  depends_on = [
    aws_dynamodb_table.user_auth,
  ]
}

resource "aws_lambda_permission" "dynamodb_permission" {
  statement_id  = "AllowDynamoDBInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.parameter_store_lambda.function_name
  principal     = "dynamodb.amazonaws.com"

  source_arn = aws_dynamodb_table.user_auth.arn
}

resource "aws_ssm_parameter" "messageToUser_parameter" {
  name  = "messageToUser-successToLogin" 
  type  = "String"
  value = var.message_to_user

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_dynamodb_table" "user_auth" {
  name           = var.dynamodb_table_name 
  billing_mode   = "PAY_PER_REQUEST"
  stream_enabled = true
  stream_view_type = "NEW_IMAGE"
  hash_key = "username"
  
  attribute {
    name = "username"
    type = "S"
  }
}
