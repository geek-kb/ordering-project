variable "name" {
  type        = string
  description = "Name of the SQS queue"
}

variable "delay_seconds" {
  type        = number
  description = "Delay in seconds for the SQS queue"
  default     = 0
}

variable "message_retention_seconds" {
  type        = number
  description = "Retention period for SQS messages"
  default     = 345600
}

variable "tags" {
  type        = map(string)
  description = "Tags for the SQS queue"
  default     = {}
}

variable "environment" {
  type        = string
  description = "Environment for the SQS queue"
  default     = ""
}

variable "project" {
  type        = string
  description = "Project for the SQS queue"
  default     = ""
}

variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function that sends messages to the SQS queue"
  default     = ""
}
