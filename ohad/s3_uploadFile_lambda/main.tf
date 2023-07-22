
resource "aws_lambda_function" "s3_uploadFile_lambda" {
  filename         = var.filename 
  function_name    = var.aws_lambda_function
  role             = aws_iam_role.s3-lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = filebase64sha256(var.filename) 

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = var.dynamodb_table_name
      S3_BUCKET_NAME      = var.S3_BUCKET_NAME
    }
  }

  depends_on = [
    aws_dynamodb_table.user_auth,
    aws_s3_bucket.user_file_backend,
  ]
}

data "archive_file" "lambda_function_zip" {
  type        = "zip"
  source_dir  = "~/iitc/Commit-Project/s3_uploadFile_lambda" 
  output_path = "~/iitc/Commit-Project/s3_uploadFile_lambda/s3_backend_package"
}


resource "aws_lambda_permission" "s3_permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_uploadFile_lambda.function_name
  principal     = "s3.amazonaws.com"

  source_arn = aws_s3_bucket.user_file_backend.arn
}


resource "aws_s3_bucket" "user_file_backend" {
  bucket = var.aws_s3_bucket 
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "user_auth" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "username"
  attribute {
    name = "username"
    type = "S"
  }
}
