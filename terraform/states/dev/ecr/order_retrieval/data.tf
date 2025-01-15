locals {
  name = "order_retrieval"
  force_destroy = true
}

data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = "itaig-terraform-state-bucket"
    key    = "ecr/${local.name}/terraform.tfstate"
    region = "us-east-1"
  }
}