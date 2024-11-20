provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      app = "lambda-api-gateway"
    }
  }
}

resource "random_pet" "lambda_bucket_name" {
  prefix = "${var.aws_lambda_function_name}-tf-func"
  length = 1
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lambda_bucket_name.id
}

resource "aws_s3_bucket_ownership_controls" "lambda_bucket" {
  bucket = aws_s3_bucket.lambda_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "lambda_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.lambda_bucket]

  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}

data "archive_file" "lambda_remora" {
  type = "zip"

  source_dir  = "../../modules/${var.aws_lambda_function_source_path}"
  output_path = "${path.module}/${var.aws_lambda_function_package_name}"
}

resource "aws_s3_object" "lambda_remora" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = var.aws_lambda_function_package_name
  source = data.archive_file.lambda_remora.output_path

  etag = filemd5(data.archive_file.lambda_remora.output_path)
}

