
module "aws_lambda" {
  source = "../../modules/aws/sqs_lambda"

  enqueue_name = "test_queue"
  environment  = "dev"
}
