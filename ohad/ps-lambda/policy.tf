
provider "aws" {
  region = "eu-north-1" 
}

resource "aws_iam_role" "parameter_store_message_lambda" {
  name = "parameter_store_message_lambda"

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