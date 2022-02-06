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
