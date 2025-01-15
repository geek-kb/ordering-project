variable "name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "enable_scan_on_push" {
  type        = bool
  description = "Enable image scan on push"
  default     = true
}

variable "image_tag_mutability" {
  type        = string
  description = "Image tag mutability setting (MUTABLE or IMMUTABLE)"
  default     = "MUTABLE"
}

variable "lifecycle_policy" {
  type        = string
  description = "Lifecycle policy JSON for the ECR repository"
  default     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images older than 30 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 30
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the ECR repository"
  default     = {}
}

variable "force_destroy" {
  type        = bool
  description = "Whether to allow the ECR repository to be destroyed"
  default     = false
}
