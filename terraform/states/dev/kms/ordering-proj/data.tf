locals {
  description            = "KMS key for encrypting application data"
  environment            = "dev"
  project                = "ordering-project"
  deletion_window_in_days = 7
  enable_key_rotation    = true
  alias                  = "ordering-key"
  tags = {
    Environment = "dev"
    Application = "my-app"
  }
}