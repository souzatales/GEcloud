resource "aws_api_gateway_rest_api" "my_api" {
  name        = var.api_gateway_name
  description = var.api_gateway_description
}

resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = var.api_gateway_res_path
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = var.api_gateway_get_method
  authorization = var.api_gateway_get_auth
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.get_method.http_method

  integration_http_method = var.api_gateway_get_integration_method
  type                    = var.api_gateway_get_integration_type
  uri                     = aws_lambda_function.remora.invoke_arn
}

resource "aws_api_gateway_deployment" "my_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = var.api_gateway_deploy_stage_name

  depends_on = [aws_api_gateway_integration.lambda_integration]
}

