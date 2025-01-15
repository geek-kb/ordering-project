variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
  default     = ""
}
variable "bucket_acl" {
  type        = string
  description = "ACL for the S3 bucket"
  default     = ""
}
variable "tags" {
  type        = map(string)
  description = "Tags to apply to the S3 bucket"
  default     = {}
}
variable "force_destroy" {
  type        = bool
  description = "Destroy all objects in the S3 bucket when destroying the bucket"
  default     = false
}
variable "region" {
  type        = string
  description = "Region for the S3 bucket"
  default     = "us-east-1"
}

variable "lifecycle_rule" {
  type = object({
    id                          = string
    enabled                     = bool
    prefix                      = string
    tags                        = map(string)
    expiration                  = object({
      days = number
    })
    noncurrent_version_expiration = object({
      days = number
    })
  })
  description = "The lifecycle rule configuration for the S3 bucket."
}


variable "versioning" {
  type        = bool
  description = "Enable versioning for the S3 bucket"
  default     = false
}
