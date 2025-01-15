terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.57.1"
    }
  }
  required_version = "1.5.5"
  backend "s3" {
    bucket = "itaig-terraform-state-bucket"
    key    = "lambda/order_verification/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

