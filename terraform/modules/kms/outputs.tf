output "key_id" {
  description = "ID of the KMS key"
  value       = aws_kms_key.key.id
}

output "key_arn" {
  description = "ARN of the KMS key"
  value       = aws_kms_key.key.arn
}

output "alias_arn" {
  description = "ARN of the KMS key alias"
  value       = aws_kms_alias.alias[0].arn
  condition   = var.alias != ""
}
