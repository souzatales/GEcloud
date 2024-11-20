module "ge-turnui-rapidproflowconnector-01" {
  source = "../../modules/lambda_remora"

  aws_lambda_function_name           = local.function_name
  api_gateway_name                   = "${local.function_name}-API"
  api_gateway_description            = "API to Invoke Lambda Function"
  api_gateway_res_path               = "${local.function_name}-resource"
  api_gateway_get_method             = "GET"
  api_gateway_get_auth               = "NONE"
  api_gateway_get_integration_method = "POST"
  api_gateway_get_integration_type   = "AWS_PROXY"
  api_gateway_deploy_stage_name      = "prod"
  secret_parameter_rp                = "rp-wazzii-prd-secret-key-01" # mandatory and must be created outside this Terraform code
  aws_region                         = "eu-west-1"
  aws_lambda_function_source_path    = "app_remora"
  aws_lambda_function_package_name   = "remora.zip"
}

locals {
  client          = "wz"
  connector       = "trn-rp"
  name            = "flowconnector"
  control_version = "01"
  function_name   = "${local.client}-${local.connector}-lambda-${local.name}-${local.control_version}"
}
