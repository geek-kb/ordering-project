output "arn" {
  value       = aws_lambda_function.func.arn
  description = "ARN of the Lambda function"
}
output "name" {
  value       = aws_lambda_function.func.function_name
  description = "Name of the Lambda function"
}

output "function_zip_filename" {
  value       = var.function_zip_filename
  description = "Name of the zipped Lambda function"
}

output "url" {
  value       = var.containerization ? "${join("",["${aws_lambda_function_url.test_live[0].function_url}","process"])}" : ""
  description = "URL of the Lambda function"
}
