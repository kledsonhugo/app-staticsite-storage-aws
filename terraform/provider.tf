# PROVIDER
terraform {

  required_version = "~> 1.8.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55"
    }
  }

  backend "s3" {
    bucket         = "${var.bucket_name}-tf"
    key            = "terraform.tfstate"
    dynamodb_table = "${var.bucket_name}-tf"
    region         = "us-east-1"
  }

}

# provider "aws" {
#   region                   = "us-east-1"
#   shared_config_files      = [".aws/config"]
#   shared_credentials_files = [".aws/credentials"]
#   profile                  = "iac"
# }