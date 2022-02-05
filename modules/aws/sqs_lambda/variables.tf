variable "enqueue_name" {
  description = "Name of the first SQS queue (enqueue)"
  type        = string
  default     = "first queue"
}

variable "environment" {
  description = "Name of the environment running this module"
  type        = string
}
