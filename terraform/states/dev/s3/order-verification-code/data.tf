locals {
  function_name = "order_verification"
  bucket_name   = "${replace(local.function_name, "_", "-")}-code"
  environment   = "dev"
  tags = {
    function_name = local.function_name
    Environment   = local.environment
  }
  bucket_acl = ""
  versioning = false
  force_destroy = true
  lifecycle_rule = {
    id      = "delete-objects-after-1-days"
    enabled = false
    prefix  = ""
    tags = {
      rule = "delete-objects-after-1-days"
    }
    expiration = {
      days = tonumber(1)
    }
    noncurrent_version_expiration = {
      days = tonumber(1)
    }
  }
}
