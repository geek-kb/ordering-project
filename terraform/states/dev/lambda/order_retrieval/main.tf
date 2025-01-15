module "order_retrieval_lambda" {
  source               = "../../../../modules/lambda"
  project              = local.project
  function_name        = local.function_name
  handler              = local.handler
  runtime              = local.runtime
  sqs_queue_arn        = local.sqs_queue_arn
  dynamodb_table_arn   = local.dynamodb_table_arn
  lambda_environment   = local.lambda_environment
  iam_lambda_role_name = local.iam_lambda_role_name
  image_uri            = local.image_uri
  tags = {
    Environment = local.environment
    Project     = local.project
  }
  containerization            = local.containerization
  function_directory          = local.function_directory
  state_path                  = local.state_path
  function_artifact_full_path = local.function_artifact_full_path
  function_zip_filename       = local.function_zip_filename
}