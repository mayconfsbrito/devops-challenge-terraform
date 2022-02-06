variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "main_queue"
}

variable "environment" {
  description = "Name of the environment running this module"
  type        = string
}

variable "first_function_name" {
  description = "Name of the first lambda function"
  type        = string
}

variable "first_function_description" {
  description = "Description of the first lambda function"
  type        = string
}

variable "first_function_source_path" {
  description = "Source path of the first lambda function"
  type        = string
}
