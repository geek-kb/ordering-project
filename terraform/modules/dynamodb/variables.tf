variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}
variable "billing_mode" {
  description = "The billing mode for the DynamoDB table (e.g., PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}
variable "hash_key" {
  description = "The primary partition key for the DynamoDB table"
  type        = string
  default     = "partitionKey" # productId
}
variable "range_key" {
  description = "The primary sort key for the DynamoDB table"
  type        = string
  default     = "sortKey" # productName
}

variable "tags" {
  description = "Tags to associate with the DynamoDB table"
  type        = map(string)
}
