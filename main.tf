

resource "aws_cognito_user_pool" "auth-user-pool-commitPro" {
  name                     = var.aws_cognito_user_pool
  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT" # This use COGNITO_DEFAULT to send emails
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    required                 = true
    developer_only_attribute = false
    mutable                  = true
  }

  schema {
    name                = "user_name"
    attribute_data_type = "String"
    required            = false

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Account Confirmation"
    email_message        = "Your confirmation code is {####}"
  }
}

resource "aws_cognito_user_pool_client" "commit-project-pool-client" {
  name         = var.aws_cognito_user_pool_client
  user_pool_id = aws_cognito_user_pool.auth-user-pool-commitPro.id

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["implicit"]
  allowed_oauth_scopes                 = ["openid", "email"]
  generate_secret                      = false
  refresh_token_validity               = 30
  prevent_user_existence_errors        = "ENABLED"
  callback_urls                        = ["https://example.com/callback"]
}

### here we can put cognito domain ###

# resource "aws_cognito_user_pool_domain" "cognito-domain" {
#   domain       = "https://example.com/""
#   user_pool_id = "${aws_cognito_user_pool.user_pool.id}"
# }
