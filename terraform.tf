
terraform {
  backend "s3" {
    bucket         = "gecloud-terraform-state-rp-turn-backend"
    key            = "staging/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform_state"
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
