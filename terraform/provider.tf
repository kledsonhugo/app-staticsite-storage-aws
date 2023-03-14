# PROVIDER
terraform {

  required_version = "~> 1.3.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55"
    }
  }

  backend "s3" {
    bucket         = "tf-staticsite-s3-state1"
    key            = "terraform.tfstate"
    dynamodb_table = "tf-staticsite-s3-state1"
    region         = "us-east-1"
  }

}

provider "aws" {
  region                   = "us-east-1"
  # shared_config_files      = ["~/.aws/config"]
  # shared_credentials_files = ["~/.aws/credentials"]
  # profile                  = "fiap"
}
