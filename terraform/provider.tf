# PROVIDER
terraform {

  required_version = "~> 1.3.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34"
    }
  }

  backend "s3" {
    bucket         = "tf-staticsite-s3-state"
    key            = "terraform.tfstate"
    dynamodb_table = "tf-staticsite-s3-state"
    region         = "us-east-1"
  }

}

provider "aws" {
  region  = "us-east-1"
}