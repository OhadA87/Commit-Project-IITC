
resource "aws_lambda_function" "dynamoDB_lambda" {
  filename         = var.file_name
  function_name    = var.dynamodb_table_name
  role             = aws_iam_role.cloudWatch_lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = filebase64sha256("~/iitc/Commit-Project/DynamoDB/lambdas-js/my_deployment_package.zip")

  environment {
    variables = {
      AUTHENTICATED = "true"
    }
  }

  tracing_config {
    mode = "Active"
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = var.aws_cloudwatch_log_group
  retention_in_days = 7
}

resource "aws_cloudwatch_log_subscription_filter" "lambda_log_filter" {
  name            = "Log_Subscription_Filter"
  log_group_name  = aws_cloudwatch_log_group.lambda_log_group.name
  filter_pattern  = "{ $.message = \"Successful authentication for user:*\" }" 
  destination_arn = aws_lambda_function.dynamoDB_lambda.arn
}

data "aws_caller_identity" "current" {}
