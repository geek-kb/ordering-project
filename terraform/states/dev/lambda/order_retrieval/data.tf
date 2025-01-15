locals {
  function_name       = "order_retrieval"
  iam_state_directory = "${element(split("_", local.function_name), 1)}_lambda_execution"
  function_directory  = "lambda_source_code"
  environment         = "dev"
  project             = "ordering-system"
  region              = "us-east-1"
  account_id          = data.aws_caller_identity.current.account_id
  handler             = "${local.function_name}.lambda_handler"
  runtime             = "python3.9"
  timeout             = 10
  memory_size         = 128
  lambda_environment = {
    SQS_QUEUE_URL = local.sqs_queue_url
    API_KEY       = sensitive(local.api_key)
  }
  tags = {
    Environment = "${local.environment}"
    Terraform   = "true"
  }
  monitored_bucket_name       = "ordering_system"
  image_uri                   = local.containerization ? "${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.function_name}:latest" : null
  sqs_queue_name              = "order-processor"
  sqs_queue_url               = data.terraform_remote_state.sqs.outputs.sqs_queue.url
  sqs_queue_arn               = data.terraform_remote_state.sqs.outputs.sqs_queue.arn
  dynamodb_table_arn          = data.terraform_remote_state.dynamodb.outputs.dynamodb_orders_table.table_arn
  dynamodb_table_name         = "orders"
  iam_lambda_role_name        = data.terraform_remote_state.iam_role.outputs.iam_lambda_execution_role.arn
  containerization            = true
  state_path                  = "../../../../states/${local.environment}/lambda"
  function_artifact_full_path = "${local.state_path}/${local.function_name}/${local.function_zip_filename}"
  function_zip_filename       = "${local.function_name}_source_code.zip"
  api_key                     = "ob03WfCcKoBJLNHvyptQiBsp2gMwcIOK"
}


data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket = "itaig-terraform-state-bucket"
    key    = "ecr/${local.function_name}/terraform.tfstate"
    region = "us-east-1"
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
