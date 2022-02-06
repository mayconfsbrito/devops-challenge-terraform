terraform {
  # This code was tested using Terraform 0.15, however it may run on previous versions
  required_version = ">= 0.15"
}

module "sqs-with-dlq" {
  source  = "damacus/sqs-with-dlq/aws"
  version = "1.0.0"

  name                        = var.queue_name
  visibility_timeout_seconds  = 43200
  alarm_sns_topic_arn         = false
  content_based_deduplication = false

  tags = {
    Service     = var.queue_name
    Environment = var.environment
  }
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.first_function_name
  description   = var.first_function_description
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = var.first_function_source_path

  tags = {
    Name = var.environment
  }
}
