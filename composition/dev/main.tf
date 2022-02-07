
module "sqs_lambda" {
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

  //Apigateway definitions
  apigateway_api_name = "main_http_api"

  //RDS database definitions
  db_instance_name       = "myoracle"
  db_instance_class      = "db.t3.large"
  db_username            = "whoiami"
  db_password            = "test123456"
  db_engine              = "oracle-ee"
  db_engine_version      = "19.0.0.0.ru-2020-10.rur-2020-10.r1"
  db_allocated_storage   = 10
  db_port                = 1521
  db_skip_final_snapshot = true
  db_license_model       = "bring-your-own-license"

  //VPC definitions
  vpc_tag_name      = "test_vpc"
  vpc_cidr          = "10.0.0.0/16"
  rds_subnet_b_cidr = "10.0.0.0/24"
  rds_subnet_c_cidr = "10.0.1.0/24"
}
