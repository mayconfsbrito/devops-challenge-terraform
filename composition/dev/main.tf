
module "aws_lambda" {
  source = "../../modules/aws/sqs_lambda"

  enqueue_name = "main_queue"
  environment  = "dev"
}
