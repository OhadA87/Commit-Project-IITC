

resource "aws_iam_role" "cloudWatch_lambda_role" {
  name = "cloudWatch_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_cloudwatch_logs_policy" {
  name        = "lambda-cloudwatch-logs-policy"
  description = "IAM policy to allow Lambda function to log to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "logs:CreateLogGroup"
        Effect   = "Allow"
        Resource = "arn:aws:logs:eu-north-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda_log_group"
      },
      {
        Action   = "logs:CreateLogStream"
        Effect   = "Allow"
        Resource = "arn:aws:logs:eu-north-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda_log_group:log-stream:*"
      },
      {
        Action   = "logs:PutLogEvents"
        Effect   = "Allow"
        Resource = "arn:aws:logs:eu-north-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda_log_group:log-stream:*"
      }
    ]
  })
}
resource "aws_lambda_permission" "cloudwatch_logs_to_lambda" {
  statement_id  = "AllowExecutionFromCloudWatchLogs"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamoDB_lambda.arn

  principal = "logs.amazonaws.com"
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_logs_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_cloudwatch_logs_policy.arn
  role       = aws_iam_role.cloudWatch_lambda_role.name
}
