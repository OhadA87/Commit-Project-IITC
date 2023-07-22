

variable "dynamodb_table_name" {
  type        = string
  default     = "user_auth"
}

variable "aws_account_id" {
  default = "commit-project"
}

variable "aws_region" {
  default = "eu-north-1"
}

variable "profile" {
  default = {}
}

variable "aws_cognito_user_pool" {
  default = "auth-user-pool-commitPro"
}

variable "aws_cognito_user_pool_client" {
  default = "commit-project-pool-client"
}
