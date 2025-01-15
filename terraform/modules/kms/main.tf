resource "aws_kms_key" "key" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy                  = var.policy != "" ? var.policy : null

  tags = var.tags
}

resource "aws_kms_alias" "alias" {
  count = var.alias != "" ? 1 : 0

  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.key.id
}
