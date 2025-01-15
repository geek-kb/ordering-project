locals {
  role_name                = "verification_execution_role"
  lambda_function_name     = "order_verification"
  project_name             = "ordering-system"
  environment              = "dev"
  s3_monitored_bucket_name = local.project_name
  s3_monitored_bucket_arn  = data.terraform_remote_state.s3_ordering_system.outputs.s3_ordering_system.arn
  s3_source_bucket_name    = "${replace(local.lambda_function_name, "_", "-")}-code"
  s3_source_bucket_arn     = data.terraform_remote_state.s3_order_verification_code.outputs.s3_order_verification_code.arn
  sqs_queue_name           = "order-processor"
  sqs_queue_arn            = data.terraform_remote_state.sqs.outputs.sqs_queue.arn
  dynamodb_table_name      = "orders"
  dynamodb_table_arn       = data.terraform_remote_state.dynamodb.outputs.dynamodb_orders_table.table_arn
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
    s3_read_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:GetObject",
            "s3:ListBucket"
          ]
          Resource = [
            "arn:aws:s3:::${local.s3_monitored_bucket_name}",
            "arn:aws:s3:::${local.s3_monitored_bucket_name}/*"
          ]
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
    dynamodb_read_write_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "dynamodb:GetItem",
            "dynamodb:Query",
            "dynamodb:Scan"
          ]
          Resource = [
            "${local.dynamodb_table_arn}",
            "${local.dynamodb_table_arn}/index/ProductIndex"
          ]
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
