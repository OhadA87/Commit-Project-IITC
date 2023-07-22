

variable "dynamodb_table_name" {
  default = "user_auth"
}

variable "aws_region" {
  default = "eu-north-1"
}

variable "aws_lambda_function" {
  default = "dynamoDB_user_auth"
}
variable "filename" {
  default = "./s3_backend_package.zip"
}