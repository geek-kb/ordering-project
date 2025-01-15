module "dynamodb" {
  source     = "../../../../modules/dynamodb"
  table_name = local.table_name
  hash_key   = local.hash_key
  range_key  = local.range_key
  # gsi_hash_key = local.gsi_hash_key
  # gsi_range_key = local.gsi_range_key
  billing_mode = local.billing_mode
  tags         = local.tags
}
