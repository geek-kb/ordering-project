resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.this.name
  policy     = var.lifecycle_policy
}

resource "aws_ecr_repository" "this" {
  name = var.name
  force_delete = var.force_destroy
  image_scanning_configuration {
    scan_on_push = var.enable_scan_on_push
  }
  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags
}
