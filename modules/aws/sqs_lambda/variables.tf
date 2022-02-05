variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "main_queue"
}

variable "environment" {
  description = "Name of the environment running this module"
  type        = string
}
