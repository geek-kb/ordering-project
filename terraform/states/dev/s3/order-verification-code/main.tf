module "s3_order_verification_code" {
  source      = "../../../../modules/s3"
  bucket_name = local.bucket_name
  tags        = local.tags
  bucket_acl  = local.bucket_acl
  lifecycle_rule = local.lifecycle_rule
  versioning     = local.versioning
}
