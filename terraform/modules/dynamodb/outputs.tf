output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.orders.name
}
output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.orders.arn
}
output "table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.orders.id
}
output "hash_key" {
  description = "Hash key of the DynamoDB table"
  value       = aws_dynamodb_table.orders.hash_key
}
