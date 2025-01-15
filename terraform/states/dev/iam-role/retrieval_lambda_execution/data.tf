locals {
  lambda_function_name     = "order_retrieval"
  project_name             = "ordering-system"
  environment              = "dev"
  region                   = "us-east-1"
  account_id               = data.aws_caller_identity.current.account_id
  role_name = "${element(split("_", local.lambda_function_name), 1)}_lambda_execution"
  sqs_queue_name           = "order-processor"
  sqs_queue_arn            = data.terraform_remote_state.sqs.outputs.sqs_queue.arn
  lambda_function_url      = "arn:aws:lambda:${local.region}:${local.account_id}:function:${local.lambda_function_name}/url/*"
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
            "sqs:GetQueueAttributes",
            "sqs:ReceiveMessage",
            "sqs:DeleteMessage",
            "sqs:GetQueueAttributes"
          ]
          Resource = "${local.sqs_queue_arn}"
        }
      ]
    },
    ecr_read_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetRepositoryPolicy",
            "ecr:DescribeRepositories",
            "ecr:ListImages",
            "ecr:DescribeImages"
          ]
          Resource = "arn:aws:ecr:${local.region}:${local.account_id}:repository/${local.lambda_function_name}"
        },
        {
          Effect   = "Allow",
          Action   = "ecr:GetAuthorizationToken",
          Resource = "*"
        }
      ]
    },
    lambda_invoke_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = "lambda:InvokeFunction"
          Resource = "${local.lambda_function_url}"
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

data "aws_caller_identity" "current" {}