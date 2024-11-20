data "aws_ssm_parameter" "secret" {
  name            = var.secret_parameter_rp
  with_decryption = true
}

resource "aws_lambda_function" "remora" {
  function_name = var.aws_lambda_function_name

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_remora.key

  handler = "webserver.lambda_handler"
  runtime = "python3.12"


  source_code_hash = data.archive_file.lambda_remora.output_base64sha256

  role = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      auth_token = "${data.aws_ssm_parameter.secret.value}"
    }
  }
}

resource "aws_cloudwatch_log_group" "remora" {
  name = "/aws/lambda/${aws_lambda_function.remora.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.aws_lambda_function_name}_serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      },
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.remora.function_name
  principal     = "apigateway.amazonaws.com"

  # Importa o ID da API Gateway
  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}
