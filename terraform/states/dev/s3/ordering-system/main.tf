module "s3_ordering_system" {
  source      = "../../../../modules/s3"
  bucket_name = local.bucket_name
  tags        = local.tags
  bucket_acl  = local.bucket_acl
  force_destroy = local.force_destroy
  lifecycle_rule = local.lifecycle_rule
  versioning     = local.versioning
}