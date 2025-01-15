resource "aws_lambda_permission" "allow_s3_trigger" {
  count = !var.containerization ? 1 : 0
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_monitored_bucket_arn

  depends_on = [aws_lambda_function.func]
}

resource "aws_s3_object" "monitored_directory" {
  count = !var.containerization ? 1 : 0

  bucket  = var.s3_monitored_bucket_name
  key     = "${var.filter_prefix}/"
  content = ""
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  count = !var.containerization ? 1 : 0

  bucket = var.s3_monitored_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.filter_prefix
    filter_suffix       = var.filter_suffix
  }

  depends_on = [
    aws_lambda_permission.allow_s3_trigger
  ]
}
data "archive_file" "source-code-zip" {
  type        = "zip"
  output_path = "${var.state_path}/${var.function_name}/${var.function_zip_filename}"

  dynamic "source" {
    for_each = [for file in fileset("${var.state_path}/${var.function_name}/${var.function_directory}/", "*") : file if file != "Dockerfile"]
    content {
      content  = file("${var.state_path}/${var.function_name}/${var.function_directory}/${source.value}")
      filename = source.value
    }
  }
}

resource "aws_s3_object" "source-code-object" {
  count = !var.containerization ? 1 : 0
  bucket = var.s3_bucket_name
  key    = var.function_zip_filename

  source      = data.archive_file.source-code-zip.output_path
  source_hash = data.archive_file.source-code-zip.output_base64sha256
  etag        = filemd5("${var.function_artifact_full_path}")
}

resource "aws_lambda_function" "func" {
  function_name    = var.function_name
  role             = var.iam_lambda_role_name
  handler          = var.containerization ? null : var.handler
  runtime          = var.containerization ? null : var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  s3_bucket        = !var.containerization ? var.s3_bucket_name : null
  s3_key           = !var.containerization ? var.s3_key : null
  image_uri        = var.containerization ? var.image_uri : null
  package_type     = var.containerization ? "Image" : "Zip"  
  source_code_hash = var.containerization ? null : data.archive_file.source-code-zip.output_base64sha256

  environment {
    variables = var.lambda_environment
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.func.function_name}"
  retention_in_days = var.log_retention_in_days

  tags = merge(
    var.tags,
    {
      Environment = var.environment,
      Project     = var.project
    }
  )

  depends_on = [aws_lambda_function.func]
}

resource "aws_lambda_function_url" "test_live" {
  count = var.containerization ? 1 : 0
  function_name      = aws_lambda_function.func.function_name
  authorization_type = "AWS_IAM"

  cors {
    allow_credentials = true
    allow_origins = ["*"]
    allow_methods     = ["POST"]
    allow_headers     = ["date", "keep-alive", "content-type", "authorization"]
    expose_headers    = ["keep-alive", "date", "content-type"]
    max_age           = 86400
  }
}