
# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
}

variable "secret_parameter_rp" {
  description = "AWS Parameter Store"
  type        = string
}

variable "aws_lambda_function_name" {
  description = "AWS Lambda Function Name"
  type        = string
}

variable "api_gateway_name" {
  type        = string
  description = "API Gateway Name"
}
variable "api_gateway_description" {
  type        = string
  description = "API Gateway Description"
}

variable "api_gateway_res_path" {
  type        = string
  description = "API Gateway Resource Name"
}

variable "api_gateway_get_method" {
  type        = string
  description = "API Gateway GET Method"
}

variable "api_gateway_get_auth" {
  type        = string
  description = "API Gateway Get Authorization"
}

variable "api_gateway_get_integration_method" {
  type        = string
  description = "API Gateway Integration Method"
}

variable "api_gateway_get_integration_type" {
  type        = string
  description = "API Gateway Integration Type"
}

variable "api_gateway_deploy_stage_name" {
  type        = string
  description = "API Gateway Desployment Stage Name"
}

variable "aws_lambda_function_source_path" {
  type        = string
  description = "AWS Lambda Function Output Name"
}

variable "aws_lambda_function_package_name" {
  type        = string
  description = "AWS Lambda Function Output Name"
}
