/**** Global variables ****/
variable "environment" {
  description = "Name of the environment running this module"
  type        = string
}

/**** Queue variables ****/
variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "main_queue"
}

/**** First lambda function variables ****/
variable "first_function_name" {
  description = "Name of the first lambda function"
  type        = string
}

variable "first_function_description" {
  description = "Description of the first lambda function (enqueue)"
  type        = string
}

variable "first_function_source_path" {
  description = "Source path of the first lambda function"
  type        = string
}

/**** Second lambda function variables ****/
variable "second_function_name" {
  description = "Name of the second lambda function"
  type        = string
}

variable "second_function_description" {
  description = "Description of the second lambda function (dequeue)"
  type        = string
}

variable "second_function_source_path" {
  description = "Source path of the second lambda function"
  type        = string
}
