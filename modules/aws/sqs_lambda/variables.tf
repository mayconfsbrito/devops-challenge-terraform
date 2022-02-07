/**** Global variables ****/
variable "environment" {
  description = "Environment name running this module"
  type        = string
}

/**** Queue variables ****/
variable "queue_name" {
  description = "SQS queue name"
  type        = string
  default     = "main_queue"
}

/**** First lambda function variables ****/
variable "first_function_name" {
  description = "Enqueue lambda function name"
  type        = string
}

variable "first_function_description" {
  description = "Enqueue lambda function name"
  type        = string
}

variable "first_function_source_path" {
  description = "Source path of the enqueue lambda function"
  type        = string
}

/**** Second lambda function variables ****/
variable "second_function_name" {
  description = "Dequeue lambda function"
  type        = string
}

variable "second_function_description" {
  description = "Dequeue lambda function description"
  type        = string
}

variable "second_function_source_path" {
  description = "Source path of the second lambda function"
  type        = string
}

/**** VPC variables ****/
variable "vpc_tag_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "rds_subnet_b_cidr" {
  description = "First subnet CIDR"
  type        = string
}

variable "rds_subnet_c_cidr" {
  description = "Second subnet CIDR"
  type        = string
}

/**** apigateway variables ****/
variable "apigateway_api_name" {
  description = "Apigateway name"
  type        = string
}

/**** RDS database variables ****/
variable "db_instance_name" {
  description = "Instance name for the RDS database"
  type        = string
}

variable "db_engine" {
  description = "RDS database engine"
  type        = string
}
variable "db_engine_version" {
  description = "Engine version for the RDS database engine"
  type        = string
}

variable "db_instance_class" {
  description = "RDS database instance class"
  type        = string
}

variable "db_username" {
  description = "RDS database username"
  type        = string
}

variable "db_password" {
  description = "RDS database password"
  type        = string
}

variable "db_port" {
  description = "RDS database port"
  type        = number
}

variable "db_allocated_storage" {
  description = "RDS database allocated storage"
  type        = string
}

variable "db_skip_final_snapshot" {
  description = "Define if the final snapshot of the RDS database should be skipped"
  type        = string
}

variable "db_license_model" {
  description = "RDS database license model"
  type        = string
}
