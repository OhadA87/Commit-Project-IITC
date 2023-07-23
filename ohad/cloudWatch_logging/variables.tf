
variable "aws_lambda_function" {
  default = "dynamoDB_user_auth"
}
variable "file_name" {
  default = "~/iitc/Commit-Project/DynamoDB/lambdas-js/my_deployment_package.zip"
}
variable "dynamodb_table_name" {
  default = "user_auth"
}
variable "aws_cloudwatch_log_group" {
  default = "authenticate_user"
}
variable "log_stream" {
  default = "dynamodb_log_auth_user"
}
