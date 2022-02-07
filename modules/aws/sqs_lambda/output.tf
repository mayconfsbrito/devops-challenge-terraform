output "queue_arn" {
  description = "Queue ARN"
  value       = module.sqs-with-dlq.queue.arn
}

output "dlq_arn" {
  description = "Dead letter queue ARN"
  value       = module.sqs-with-dlq.deadletter_queue.arn
}

