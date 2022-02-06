
module "aws_lambda" {
  source = "../../modules/aws/sqs_lambda"

  queue_name  = "main_queue"
  environment = "dev"
}
