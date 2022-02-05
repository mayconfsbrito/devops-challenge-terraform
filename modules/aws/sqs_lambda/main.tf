terraform {
  # This code was tested using Terraform 0.15, however it may run on previous versions
  required_version = ">= 0.15"
}

module "first_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name = var.queue_name

  tags = {
    Service     = var.queue_name
    Environment = var.environment
  }
}
