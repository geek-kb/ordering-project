resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = var.tags
  force_destroy = var.force_destroy
}
resource "aws_s3_bucket_acl" "bucket_acl" {
  count = var.bucket_acl != "" ? 1 : 0

  bucket = aws_s3_bucket.bucket.id
  acl    = var.bucket_acl
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = var.lifecycle_rule.id
    status = var.lifecycle_rule.enabled ? "Enabled" : "Disabled"
    filter {
      prefix = var.lifecycle_rule.prefix
    }
    expiration {
      days = var.lifecycle_rule.expiration.days
    }

    noncurrent_version_expiration {
      noncurrent_days = var.lifecycle_rule.noncurrent_version_expiration.days
    }
  }
}
