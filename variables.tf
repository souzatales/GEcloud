
# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-1"
}

variable "secret_parameter_rp" {
  type    = string
  default = "secret_key_rp_wazzii_staging"
}
