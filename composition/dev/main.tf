
module "aws_lambda" {
  source = "../../modules/aws/lambda"

  enqueue_name = "test_queue"
  environment  = "dev"
}
