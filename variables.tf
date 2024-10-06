
# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "us-east-1"
}

variable "secret_parameter_name" {
  type    = string
  default = "secret_key"
}
