output "name" {
  value = aws_s3_bucket.bucket.bucket
}
output "arn" {
  value = aws_s3_bucket.bucket.arn
}
output "tags" {
  value = aws_s3_bucket.bucket.tags
}
output "force_destroy" {
  value = aws_s3_bucket.bucket.force_destroy
}
output "lifecycle_rule" {
  value = var.lifecycle_rule
}
