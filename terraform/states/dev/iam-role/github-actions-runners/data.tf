locals {
  lambda_function_name     = "order_retrieval"
  project_name             = "ordering-system"
  environment              = "dev"
  region                   = "us-east-1"
  account_id               = data.aws_caller_identity.current.account_id
  role_name = "${element(split("_", local.lambda_function_name), 1)}_lambda_execution"
  sqs_queue_name           = "order-processor"
  sqs_queue_arn            = data.terraform_remote_state.sqs.outputs.sqs_queue.arn
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  inline_policies_to_attach = {
    lambda_execution_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Resource = "*"
        }
      ]
    },
    sqs_read_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "sqs:SendMessage",
            "sqs:GetQueueAttributes"
          ]
          Resource = "${local.sqs_queue_arn}"
        }
      ]
    },
    ecr_access_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow",
          Action   = [
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:PutImage",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload",
            "ecr:DescribeRepositories",
            "ecr:ListImages"
          ],
          Resource = "arn:aws:ecr:${local.region}:${local.account_id}:repository/${local.lambda_function_name}"
        },
        {
          Effect   = "Allow",
          Action   = "ecr:GetAuthorizationToken",
          Resource = "*"
        }
      ]
    }
  }
  managed_iam_policies_to_attach = []
  tags = {
    Environment = "${local.environment}"
    Project     = "${local.project_name}"
    Function    = "${local.lambda_function_name}"
  }
}

data "terraform_remote_state" "sqs" {
  backend = "s3"
  config = {
    bucket = "itaig-terraform-state-bucket"
    key    = "sqs/${local.sqs_queue_name}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "dynamodb" {
  backend = "s3"
  config = {
    bucket = "itaig-terraform-state-bucket"
    key    = "dynamodb/${local.dynamodb_table_name}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "s3_ordering_system" {
  backend = "s3"
  config = {
    bucket = "itaig-terraform-state-bucket"
    key    = "s3/${local.s3_monitored_bucket_name}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "s3_order_verification_code" {
  backend = "s3"
  config = {
    bucket = "itaig-terraform-state-bucket"
    key    = "s3/${local.s3_source_bucket_name}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_caller_identity" "current" {}