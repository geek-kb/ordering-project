module "ecr" {
  source = "../../../../modules/ecr"
  name   = local.name
  force_destroy = local.force_destroy
}
