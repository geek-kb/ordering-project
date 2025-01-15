locals {
  function_name            = "order_verification"
  iam_state_directory = "${element(split("_", local.function_name), 1)}_lambda_execution"
  function_directory       = "lambda_source_code"
  environment              = "dev"
  project                  = "ordering-system"
  region                   = "us-east-1"
  account_id               = data.aws_caller_identity.current.account_id
  s3_monitored_bucket_name = "ordering-system"
  s3_monitored_bucket_arn  = data.terraform_remote_state.s3_ordering_system.outputs.s3_ordering_system.arn
  handler                  = "${local.function_name}.lambda_handler"
  runtime                  = "python3.9"
  timeout                  = 10
  memory_size              = 128
  image_uri                = null
  lambda_environment = {
    SQS_QUEUE_URL       = local.sqs_queue_url
    DYNAMODB_TABLE_NAME = local.dynamodb_table_name
  }
  tags = {
    Environment = "${local.environment}"
    Terraform   = "true"
  }
  s3_bucket_name              = "${replace(local.function_name, "_", "-")}-code"
  s3_key                      = local.function_zip_filename
  s3_code_path                = "${local.s3_bucket_name}/${local.s3_key}"
  s3_bucket_arn               = data.terraform_remote_state.s3_order_verification_code.outputs.s3_order_verification_code.arn
  sqs_queue_name              = "order-processor"
  sqs_queue_url               = data.terraform_remote_state.sqs.outputs.sqs_queue.url
  sqs_queue_arn               = data.terraform_remote_state.sqs.outputs.sqs_queue.arn
  dynamodb_table_arn          = data.terraform_remote_state.dynamodb.outputs.dynamodb_orders_table.table_arn
  dynamodb_table_name         = "orders"
  iam_lambda_role_name        = data.terraform_remote_state.iam_role.outputs.iam_lambda_execution_role.arn
  filter_prefix               = "orders"
  filter_suffix               = ".json"
  containerization            = false
  state_path                  = "../../../../states/${local.environment}/lambda"
  function_artifact_full_path = "${local.state_path}/${local.function_name}/${local.function_zip_filename}"
  function_zip_filename       = "${local.function_name}_source_code.zip"
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
    key    = "s3/${local.s3_bucket_name}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "iam_role" {
  backend = "s3"
  config = {
    bucket = "itaig-terraform-state-bucket"
    key    = "iam-role/${local.iam_state_directory}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_caller_identity" "current" {
  provider = aws
}