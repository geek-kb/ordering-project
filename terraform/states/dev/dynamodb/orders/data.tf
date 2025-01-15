locals {
  table_name   = "orders"
  environment  = "dev"
  project      = "ordering-system"
  hash_key     = "partitionKey" # Matches the hash_key defined in main.tf
  range_key    = "sortKey"      # Matches the range_key defined in main.tf
  billing_mode = "PAY_PER_REQUEST"

  # Tags for the table
  tags = {
    Environment = local.environment
    Project     = local.project
  }
}