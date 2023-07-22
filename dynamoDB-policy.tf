

resource "aws_iam_role" "dynamoDB_lambda_role" {
  name = "dynamoDB-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "dynamoDB_lambda_policy" {
  name        = "dynamoDB-lambda-policy"
  description = "IAM policy for my Lambda function"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        "Action" : [
          "dynamodb:PutItem"
        ],
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/${var.dynamodb_table_name}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  role       = aws_iam_role.dynamoDB_lambda_role.name
  policy_arn = aws_iam_policy.dynamoDB_lambda_policy.arn
}



# resource "aws_iam_policy" "dynamoDB_lambda_policy" {
#   name        = "dynamoDB-lambda-policy"
#   description = "IAM policy for my Lambda function"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "dynamodb:PutItem"
#       ],
#       "Resource": "arn:aws:dynamodb:$${aws:region}:$${aws:AccountId}:table/$${aws:PrincipalTag/user_name}"
#     }
#   ]
# }

# EOF
# }


# resource "aws_lambda_function" "dynamoDB_lambda_function" {
#   function_name = "dynamoDB-lambda-function"
#   runtime       = "nodejs14.x"
#   handler       = "index.handler"
#   timeout       = 10

#   role = aws_iam_role.dynamoDB_lambda_role.arn

#   filename         = "/lambda_function.zip"
#   source_code_hash = filebase64sha256("lambda_function.zip")

# }
