module "kms" {
  source                 = "../../../../modules/kms"
  description            = local.description
  environment            = local.environment
  project                = local.project
  deletion_window_in_days = local.deletion_window_in_days
  enable_key_rotation    = local.enable_key_rotation
  alias                  = local.alias
  tags = {
    Environment = "dev"
    Project    = "ordering-project"
  }
}