
# Output value definitions

output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."

  value = aws_s3_bucket.lambda_bucket.id
}

output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.remora.function_name
}

output "api_gateway_id" {
  description = "ID do API Gateway"
  value       = aws_api_gateway_rest_api.my_api.id
}

output "invoke_url" {
  description = "URL para invocar a API"
  value       = "${aws_api_gateway_rest_api.my_api.execution_arn}/myresource"
}
