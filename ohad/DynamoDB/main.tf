

resource "aws_dynamodb_table" "user_auth" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "username"
  attribute {
    name = "username"
    type = "S"
  }
}

resource "aws_lambda_function" "dynamoDB_lambda" {
  filename         = var.filename
  function_name    = var.dynamodb_table_name
  role             = aws_iam_role.dynamoDB_lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = filebase64sha256("~/iitc/Commit-Project/s3_backend/s3_backend_package.zip")
}

resource "aws_lambda_permission" "dynamodb_permission" {
  statement_id  = "AllowDynamoDBInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamoDB_lambda.function_name
  principal     = "dynamodb.amazonaws.com"
  source_arn    = aws_dynamodb_table.user_auth.arn
}

data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
