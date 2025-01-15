variable "ssm_params" {
  type    = map(string)
  default = {}
}

variable "kms_key_id" {
  description = "The KMS key id or arn for encrypting a SecureString"
  type        = string
  default     = "alias/aws/ssm"
}

variable "prefix" {
  description = "Prefix added to ssm parameter name"
  type        = string
  default     = ""
}

variable "unencrypted_suffix" {
  description = "Parameters with this suffix in the name will be saved as plaintext values."
  type        = string
  default     = "_unencrypted"
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