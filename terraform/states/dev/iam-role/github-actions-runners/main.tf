module "iam_lambda_execution_role" {
  source                         = "../../../../modules/iam-role"
  role_name                      = local.role_name
  assume_role_policy             = local.assume_role_policy
  managed_iam_policies_to_attach = local.managed_iam_policies_to_attach
  tags                           = local.tags
  inline_policies_to_attach      = local.inline_policies_to_attach
}
