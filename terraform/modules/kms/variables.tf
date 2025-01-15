variable "description" {
  type        = string
  description = "Description of the KMS key"
  default     = "Managed by Terraform"
}

variable "deletion_window_in_days" {
  type        = number
  description = "Number of days before the KMS key is deleted after destruction"
  default     = 30
}

variable "enable_key_rotation" {
  type        = bool
  description = "Whether key rotation is enabled"
  default     = true
}

variable "policy" {
  type        = string
  description = "Custom key policy in JSON format"
  default     = ""
}

variable "alias" {
  type        = string
  description = "Optional alias name for the KMS key"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the KMS key"
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