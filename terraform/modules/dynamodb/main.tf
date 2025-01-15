resource "aws_dynamodb_table" "orders" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key
  range_key    = var.range_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  attribute {
    name = var.range_key
    type = "S"
  }

  attribute {
    name = "orderId"
    type = "S"
  }

  # Adding a Global Secondary Index (GSI) for querying based on orderId
  global_secondary_index {
    name            = "OrderIndex"
    hash_key        = "orderId"
    range_key       = "partitionKey"
    projection_type = "ALL"
  }

  tags = var.tags
}