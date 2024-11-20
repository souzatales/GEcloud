
terraform {
  # We can't reference variables here and the key must be unique for each environment
  backend "s3" {
    bucket         = "ge-terraform-s3-01"
    key            = "prod/wz/terraform.tfstate" # Change for each environment under /env folder
    region         = "eu-west-1"
    dynamodb_table = "ge-terraform-s3-01-terraform-state"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.2"
    }
  }

  required_version = "~> 1.2"
}
