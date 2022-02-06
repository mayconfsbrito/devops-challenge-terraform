
module "aws_lambda" {
  source = "../../modules/aws/sqs_lambda"

  queue_name  = "main_queue"
  environment = "dev"

  first_function_name        = "first_function"
  first_function_description = "Function to enqueue the request to the SQS queue"
  first_function_source_path = "./src/first_function"
}
