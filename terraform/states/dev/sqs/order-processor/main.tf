module "sqs" {
  source                    = "../../../../modules/sqs"
  name                      = local.name
  delay_seconds             = local.delay_seconds
  message_retention_seconds = local.message_retention_seconds
  tags                      = local.tags
  environment               = local.environment
  project                   = local.project
}
