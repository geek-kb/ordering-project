variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
  default     = ""
}
variable "function_directory" {
  type        = string
  description = "Directory containing the Lambda function code. Used if containerization is false."
}
variable "environment" {
  type        = string
  description = "Environment for the Lambda function"
  default     = ""
}
variable "project" {
  type        = string
  description = "Name of the project"
  default     = ""
}
variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}
variable "s3_monitored_bucket_name" {
  type        = string
  description = "The name of the S3 bucket the Lambda function monitors for events"
  default     = ""
}
variable "s3_monitored_bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket the Lambda function monitors for events"
  default     = ""
}
variable "handler" {
  type        = string
  description = "Handler for the Lambda function (used for S3-based deployment)"
  default     = ""
}
variable "runtime" {
  type        = string
  description = "Runtime for the Lambda function (used for S3-based deployment)"
  default     = ""
}

variable "timeout" {
  type        = number
  description = "Timeout for the Lambda function in minutes"
  default     = 3
}
variable "memory_size" {
  type        = number
  description = "Memory size for the Lambda function"
  default     = 128
}
variable "iam_lambda_role_name" {
  type        = string
  description = "Name of the IAM role for the Lambda function"
  default     = ""
}
variable "image_uri" {
  type        = string
  description = "URI of the container image for the Lambda function"
}
variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket where the Lambda function code is stored (used for S3-based deployment)"
  default     = ""
}
variable "s3_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket where the Lambda function code is stored (used for S3-based deployment)"
  default     = ""
}
variable "s3_key" {
  type        = string
  description = "S3 key for the Lambda function code (used for S3-based deployment)"
  default     = ""
}
variable "s3_code_path" {
  type        = string
  description = "Path to the local Lambda function code (used for S3-based deployment)"
  default     = ""
}
variable "sqs_queue_arn" {
  type        = string
  description = "ARN of the SQS queue the Lambda interacts with"
  default     = ""
}
variable "dynamodb_table_arn" {
  type        = string
  description = "ARN of the DynamoDB table the Lambda queries"
  default     = ""
}
variable "lambda_environment" {
  type        = map(string)
  description = "Environment variables for the Lambda function"
  default     = {}
}
variable "tags" {
  type        = map(string)
  description = "Tags for the Lambda function"
  default     = {}
}
variable "containerization" {
  type        = bool
  description = "Whether the Lambda function is containerized"
  default     = false
}
variable "monitored_bucket_events" {
  type        = list(string)
  description = "A list of S3 events to trigger the Lambda function (e.g., s3:ObjectCreated:*)"
  default     = ["s3:ObjectCreated:*"]
}
variable "state_path" {
  type        = string
  description = "Path to the states directory"
  # default     = "../../../terraform/states"

}
variable "function_artifact_full_path" {
  type        = string
  description = "Full path to the Lambda function artifact"
  default     = ""
}
variable "function_zip_filename" {
  type        = string
  description = "Name of the zipped Lambda function"
  default     = ""
}
variable "filter_prefix" {
  type        = string
  description = "Prefix for the S3 bucket notification filter"
  default     = ""
}
variable "filter_suffix" {
  type        = string
  description = "Suffix for the S3 bucket notification filter"
  default     = ""
}

variable "api_key" {
  type        = string
  description = "API key for the Lambda function"
  default     = ""
  sensitive = true 
}

variable "log_retention_in_days" {
  type        = number
  description = "Number of days to retain logs for the Lambda function"
  default     = 14
}