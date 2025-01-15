module "order_verification_lambda" {
  source                   = "../../../../modules/lambda"
  project                  = local.project
  function_name            = local.function_name
  handler                  = local.handler
  runtime                  = local.runtime
  s3_bucket_name           = local.s3_bucket_name
  s3_bucket_arn            = local.s3_bucket_arn
  s3_key                   = local.s3_key
  s3_code_path             = local.s3_code_path
  s3_monitored_bucket_name = local.s3_monitored_bucket_name
  sqs_queue_arn            = local.sqs_queue_arn
  dynamodb_table_arn       = local.dynamodb_table_arn
  lambda_environment       = local.lambda_environment
  iam_lambda_role_name     = local.iam_lambda_role_name
  tags = {
    Environment = local.environment
    Project     = local.s3_monitored_bucket_name
  }
  containerization            = local.containerization
  function_directory          = local.function_directory
  state_path                  = local.state_path
  function_artifact_full_path = local.function_artifact_full_path
  function_zip_filename       = local.function_zip_filename
  filter_prefix               = local.filter_prefix
  filter_suffix               = local.filter_suffix
  image_uri = local.image_uri
}