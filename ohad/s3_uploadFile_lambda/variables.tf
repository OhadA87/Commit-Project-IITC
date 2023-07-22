
variable "dynamodb_table_name" {
  default = "user_auth"
}

variable "aws_region" {
  default = "eu-north-1"
}

variable "aws_lambda_function" {
  default = "s3_uploadFile_lambda"
}

variable "s3-lambda_role" {
  default = "s3-lambda-role"
}

variable "filename" {
  default = "./s3_backend_package.zip"
}

variable "s3_access_policy" {
  default = "s3-access-policy"
}

variable "S3_BUCKET_NAME" {
  default = "user_file_web_app"
}

variable "aws_s3_bucket" {
  default = "user-auth-web"
}
