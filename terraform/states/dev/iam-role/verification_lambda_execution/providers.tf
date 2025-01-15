terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82.2"
    }
  }
  required_version = "1.5.5"
  backend "s3" {
    bucket = "itaig-terraform-state-bucket"
    key    = "iam-role/verification_lambda_execution/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

