
module "aws_lambda" {
  source      = "../../modules/aws/sqs_lambda"
  environment = "dev"

  //Queue
  queue_name = "main_queue"

  //First lambda function (enqueue)
  first_function_name        = "enqueue_function"
  first_function_description = "Function to enqueue the request to the SQS queue"
  first_function_source_path = "./src/enqueue_function"

  //Second lambda function (dequeue)
  second_function_name        = "dequeue_function"
  second_function_description = "Function to enqueue the request to the SQS queue"
  second_function_source_path = "./src/dequeue_function"
}
