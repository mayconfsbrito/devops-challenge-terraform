terraform {
  # This code was tested using Terraform 0.15, however it may run on previous versions
  required_version = ">= 0.15"
}

/*
* IAM Resources
*/
resource "aws_iam_role" "run_sqs_enqueue" {
  name = "${var.first_function_name}-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "${var.first_function_name}-iam-policy"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sqs:SendMessage",
            "sqs:ChangeMessageVisibility"
          ],
          "Resource" : "arn:aws:sqs:*:*:${var.first_function_name}"
        }
      ]
    })
  }
}

resource "aws_iam_role" "run_sqs_dequeue" {
  name = "${var.second_function_name}-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "${var.second_function_name}-iam-policy"
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sqs:ChangeMessageVisibility",
            "sqs:ReceiveMessage"
          ],
          "Resource" : "arn:aws:sqs:*:*:${var.first_function_name}"
        }
      ]
    })
  }
}


/*
* SQS Resources
*/
module "sqs-with-dlq" {
  source  = "damacus/sqs-with-dlq/aws"
  version = "1.0.0"

  name                        = var.queue_name
  visibility_timeout_seconds  = 43200
  alarm_sns_topic_arn         = false
  content_based_deduplication = false

  tags = {
    Service     = var.queue_name
    Environment = var.environment
  }
}

/*
* Lambda Resources
*/
module "enqueue_lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.first_function_name
  description   = var.first_function_description
  handler       = "index.lambda_handler"
  runtime       = "nodejs14.x"
  create_role   = false
  lambda_role   = aws_iam_role.run_sqs_enqueue.arn

  source_path = var.first_function_source_path

  tags = {
    Name = var.environment
  }
}

module "dequeue_lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.second_function_name
  description   = var.second_function_description
  handler       = "index.lambda_handler"
  runtime       = "nodejs14.x"
  create_role   = false
  lambda_role   = aws_iam_role.run_sqs_dequeue.arn

  source_path = var.second_function_source_path

  tags = {
    Name = var.environment
  }
}

resource "aws_apigatewayv2_api" "main_apigateway" {
  name          = "main_http_api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "main_apigateway_integration" {
  api_id           = aws_apigatewayv2_api.main_apigateway.id
  integration_type = "HTTP_PROXY"

  integration_method = "ANY"
  integration_uri    = "https://example.com/{proxy}"
}

resource "aws_apigatewayv2_route" "main_apigateway_route" {
  api_id    = aws_apigatewayv2_api.main_apigateway.id
  route_key = "ANY /{proxy+}"

  target = "integrations/${aws_apigatewayv2_integration.main_apigateway_integration.id}"
}
