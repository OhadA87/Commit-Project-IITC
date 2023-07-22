
variable "lambda_function_code_path" {
  default     = "./ps_lambda_package.zip"
}
variable "dynamodb_table_name" {
  type        = string
  default     = "user_auth"
}
variable "parameter_store_parameter_name" {
  default     = "ps-user-login-success"
}
variable "function_name" {
  default     = "ps-login-success"
}
variable "message_to_user" {
  type        = string
  default     = "messageToUser-successToLogin" 
}