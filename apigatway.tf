# provider "aws" {
#   region = "eu-west-1"
# }

# resource "aws_lambda_function" "my_lambda" {
#   function_name = "my_lambda_function"
#   runtime       = "python3.8"
#   handler       = "app.lambda_handler"
#   role          = aws_iam_role.lambda_exec.arn

#   # Pacote o código Lambda em um arquivo .zip
#   filename      = "lambda_function.zip"
  
#   source_code_hash = filebase64sha256("lambda_function.zip")
# }

# resource "aws_iam_role" "lambda_exec" {
#   name = "lambda_exec_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#         Effect    = "Allow"
#         Sid       = ""
#       }
#     ]
#   })
# }

resource "aws_api_gateway_rest_api" "my_api" {
  name        = "MyAPI"
  description = "API para invocar a função Lambda"
}

resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "myresource"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.get_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.hello_world.invoke_arn
}

# resource "aws_lambda_permission" "allow_api_gateway" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.my_lambda.function_name
#   principal     = "apigateway.amazonaws.com"

#   # Importa o ID da API Gateway
#   source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
# }

# output "invoke_url" {
#   value = "${aws_api_gateway_rest_api.my_api.execution_arn}/myresource"
# }


resource "aws_api_gateway_deployment" "my_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "prod"

  depends_on = [aws_api_gateway_integration.lambda_integration]
}
