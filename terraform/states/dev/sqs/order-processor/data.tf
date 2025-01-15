locals {
  name                      = "order-processor"
  environment               = "dev"
  project                   = "ordering-system"
  lambda_function_name      = "order_verification"
  delay_seconds             = 0
  message_retention_seconds = 345600
  tags = {
    Environment = "${local.environment}"
    Project     = "${local.project}"
    Publisher   = "${local.lambda_function_name}"
  }
}
