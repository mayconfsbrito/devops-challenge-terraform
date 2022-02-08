# DevOps Challenge

## Index

* [Instructions](#instructions)
* [Current Architecture](#current-architecture)
* [Current Diagram](#current-diagram)
* [Proposed Architecture](#proposed-architecture)
* [Terraform Plan](#terraform-plan-terratest)
* [CICD - Automation (Bonus)](#cicd-automation-bonus)
* [Observability (Bonus)](#observability-bonus)
* [Permissions (Bonus)](#permissions-bonus)
* [Best Practices (Bonus)](#best-practices-bonus)
* [Disaster Recovery Plan (Bonus)](#disaster-recovery-plan-bonus)
* [Compliance (Bonus)](#compliance-bonus)
* [Migration](#migration)
* [Budget (Bonus)](#budget-bonus)
* [Next Steps](#next-steps)

## Instructions

This challenge poses to test your experience on DevOps and the usual technologies applied.The most important thing for us is that you show your expertise and best practices.

Read the case specified in the Current Architecture section, and perform the steps described. We expect to see Terraform code to provision at least part of your proposed Architecture. We will consider favorably all bonus points you complete.

We have added some example modules to begin the migration into Azure. You may use them or delete them.


## Current Architecture
<details>
<summary><b>Test Details</b></summary>

---

Let’s imagine that a Bank has a monolithic architecture to handle the enrollment for new credit cards.
A potential customer will enter a bunch of data through some online forms.
Once a day there will be a batch processing job that will process all this
data. The job will trigger a monolithic application that extracts the day’s
data and run the following tasks.

• It will verify if it’s an existing customer and if it is, it will verify any
potential loans or red flags in case the customer is not eligible for a
new credit card.

• It will verify the customer’s identity. We reach an external API (e.g.
Equifax) to verify all the provided details are accurate and also verify
if there is any red flag.

• It will calculate the amount limit assigned for the credit card. It will
also auto-generate a new Credit Card number so the customer can
start using it right away until the actual credit card is received.

All the data is currently persisted on an on-premise Oracle DB. This DB
holds all the personal data the user inputs in the forms and also additional
data that will help to calculate his/her credit rating.

#### The Goal
As a company-wide initiative, we’ve been asked to
1. Migrate all our systems to a cloud provider (You may plan for AWS, Google Cloud or Azure)
2. The company is shifting to event-driven architecture with microservices
</details>

<details>
<summary><b>Tasks</b></summary>

#### The Test

This test will mix some designs (text and diagrams are expected) and
some coding. We are absolutely not aiming to build this system. We just
want to test some relevant points we’ll explicitly point out.
1. Given the 2 goals we mentioned in the previous section, imagine a
new architecture including text, diagrams, and any other useful
resource.
2. How are you going to handle the migration of data? Design a
strategy (maybe using cloud resources o anything else?) and tell us
about it.
3. Let’s assume the current DB is a traditional Oracle relational DB.
Write all the necessary scripts to migrate this data to a new DB in
the cloud. There are several options. Please explain which one you
choose and why.
4. Given the new architecture you designed let’s assume we’ll provision
new resources through Terraform. Build some of the most important
infrastructure with Terraform and build the plan for it.
5. (Bonus) What kind of monitoring would be relevant to add? What kind of
resources would be helpful to achieve this?
6. (Bonus) Give special attention how to handle exceptions if the job
stops for any reason. How do we recover? How will the deployment
process will be? Also, think about permissions, how are we giving the
cloud resources permissions?

We are expecting:
1. A detailed explanation for each step
2. The reasons to choose each resource in the cloud.
3. Details on how those resources work. 
---
</details>

## Current Diagram
![alt text](/images/current_example.png "Current diagram")

## FAQ

<details>
<summary>User / Permissions Migration</summary>

```
Are the users using auth/authentication federated service? SSO auth?

User’s apply through filling out forms without the necessity of creating an account with the bank (it is open to anyone)
so there should be no auth involved.
In the future we might incorporate federated auth that will allow us to fill out some information that we currently
request to users. So any prep work for the future would be great.
```
</details>


## Proposed Architecture

![alt text](/images/proposed_example.png "Proposed diagram")

## Requirements

1. Terraform v1.1.5
2. AWS Account - With admin permissions to create resources for these services:
    * IAM
    * Lambda
    * SQS
    * RDS
    * EC2 (VPC)
3. Aws cli v2.1.3 
    * Default profile configured with the AWS account above


## Constrains

- Database allocated storage
- Oracle database license mode (bring your own license) and version
- RDS instance database class (db.t3.large)
- Resources will be deployed in us-west-1 region
- Lambda function codes are just a hello world example
- Were Endpoints/services for each task were not created



## Terraform plan / Terratest

Add Output of Terraform Plan
<details>
<summary>Summary</summary>
  
```

------------------------------------------------------------------------
------------------------------------------------------------------------

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # module.sqs_lambda.aws_apigatewayv2_api.main_apigateway will be created
  + resource "aws_apigatewayv2_api" "main_apigateway" {
      + api_endpoint                 = (known after apply)
      + api_key_selection_expression = "$request.header.x-api-key"
      + arn                          = (known after apply)
      + execution_arn                = (known after apply)
      + id                           = (known after apply)
      + name                         = "main_http_api"
      + protocol_type                = "HTTP"
      + route_selection_expression   = "$request.method $request.path"
      + tags_all                     = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
        }
    }

  # module.sqs_lambda.aws_apigatewayv2_integration.main_apigateway_integration will be created
  + resource "aws_apigatewayv2_integration" "main_apigateway_integration" {
      + api_id                                    = (known after apply)
      + connection_type                           = "INTERNET"
      + id                                        = (known after apply)
      + integration_method                        = "ANY"
      + integration_response_selection_expression = (known after apply)
      + integration_type                          = "HTTP_PROXY"
      + integration_uri                           = "https://example.com/{proxy}"
      + payload_format_version                    = "1.0"
      + timeout_milliseconds                      = (known after apply)
    }

  # module.sqs_lambda.aws_apigatewayv2_route.main_apigateway_route will be created
  + resource "aws_apigatewayv2_route" "main_apigateway_route" {
      + api_id             = (known after apply)
      + api_key_required   = false
      + authorization_type = "NONE"
      + id                 = (known after apply)
      + route_key          = "ANY /{proxy+}"
      + target             = (known after apply)
    }

  # module.sqs_lambda.aws_db_instance.default will be created
  + resource "aws_db_instance" "default" {
      + address                               = (known after apply)
      + allocated_storage                     = 10
      + apply_immediately                     = (known after apply)
      + arn                                   = (known after apply)
      + auto_minor_version_upgrade            = true
      + availability_zone                     = (known after apply)
      + backup_retention_period               = (known after apply)
      + backup_window                         = (known after apply)
      + ca_cert_identifier                    = (known after apply)
      + character_set_name                    = (known after apply)
      + copy_tags_to_snapshot                 = false
      + db_subnet_group_name                  = (known after apply)
      + delete_automated_backups              = true
      + endpoint                              = (known after apply)
      + engine                                = "oracle-ee"
      + engine_version                        = "19.0.0.0.ru-2020-10.rur-2020-10.r1"
      + engine_version_actual                 = (known after apply)
      + hosted_zone_id                        = (known after apply)
      + id                                    = (known after apply)
      + identifier                            = "myoracle"
      + identifier_prefix                     = (known after apply)
      + instance_class                        = "db.t3.large"
      + kms_key_id                            = (known after apply)
      + latest_restorable_time                = (known after apply)
      + license_model                         = "bring-your-own-license"
      + maintenance_window                    = (known after apply)
      + monitoring_interval                   = 0
      + monitoring_role_arn                   = (known after apply)
      + multi_az                              = (known after apply)
      + name                                  = "myoracle"
      + nchar_character_set_name              = (known after apply)
      + option_group_name                     = (known after apply)
      + parameter_group_name                  = (known after apply)
      + password                              = (sensitive value)
      + performance_insights_enabled          = false
      + performance_insights_kms_key_id       = (known after apply)
      + performance_insights_retention_period = (known after apply)
      + port                                  = 1521
      + publicly_accessible                   = false
      + replicas                              = (known after apply)
      + resource_id                           = (known after apply)
      + skip_final_snapshot                   = true
      + snapshot_identifier                   = (known after apply)
      + status                                = (known after apply)
      + storage_type                          = (known after apply)
      + tags_all                              = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
        }
      + timezone                              = (known after apply)
      + username                              = "whoiami"
      + vpc_security_group_ids                = (known after apply)
    }

  # module.sqs_lambda.aws_db_subnet_group.rds_subnet_group will be created
  + resource "aws_db_subnet_group" "rds_subnet_group" {
      + arn         = (known after apply)
      + description = "Managed by Terraform"
      + id          = (known after apply)
      + name        = "db_myoracle_subnet"
      + name_prefix = (known after apply)
      + subnet_ids  = (known after apply)
      + tags        = {
          + "Name" = "test_vpc"
        }
      + tags_all    = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "test_vpc"
          + "Project"     = "SQS Lambda RDS Test"
        }
    }

  # module.sqs_lambda.aws_iam_role.run_sqs_dequeue will be created
  + resource "aws_iam_role" "run_sqs_dequeue" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "lambda.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "dequeue_function-iam-role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
        }
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = "dequeue_function-iam-policy"
          + policy = jsonencode(
                {
                  + Statement = [
                      + {
                          + Action   = [
                              + "sqs:ChangeMessageVisibility",
                              + "sqs:ReceiveMessage",
                            ]
                          + Effect   = "Allow"
                          + Resource = "arn:aws:sqs:*:*:enqueue_function"
                        },
                    ]
                  + Version   = "2012-10-17"
                }
            )
        }
    }

  # module.sqs_lambda.aws_iam_role.run_sqs_enqueue will be created
  + resource "aws_iam_role" "run_sqs_enqueue" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "lambda.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "enqueue_function-iam-role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
        }
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = "enqueue_function-iam-policy"
          + policy = jsonencode(
                {
                  + Statement = [
                      + {
                          + Action   = [
                              + "sqs:SendMessage",
                              + "sqs:ChangeMessageVisibility",
                            ]
                          + Effect   = "Allow"
                          + Resource = "arn:aws:sqs:*:*:enqueue_function"
                        },
                    ]
                  + Version   = "2012-10-17"
                }
            )
        }
    }

  # module.sqs_lambda.aws_security_group.rds_sg will be created
  + resource "aws_security_group" "rds_sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "10.0.0.0/16",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "10.0.0.0/16",
                ]
              + description      = ""
              + from_port        = 1521
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 1521
            },
        ]
      + name                   = "test_vpc-rds-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "test_vpc"
        }
      + tags_all               = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "test_vpc"
          + "Project"     = "SQS Lambda RDS Test"
        }
      + vpc_id                 = (known after apply)
    }

  # module.sqs_lambda.aws_subnet.rds_subnet_b will be created
  + resource "aws_subnet" "rds_subnet_b" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.0.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "test_vpc"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "test_vpc"
          + "Project"     = "SQS Lambda RDS Test"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.sqs_lambda.aws_subnet.rds_subnet_c will be created
  + resource "aws_subnet" "rds_subnet_c" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-1c"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "test_vpc"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "test_vpc"
          + "Project"     = "SQS Lambda RDS Test"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.sqs_lambda.aws_vpc.rds_vpc will be created
  + resource "aws_vpc" "rds_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_classiclink                   = (known after apply)
      + enable_classiclink_dns_support       = (known after apply)
      + enable_dns_hostnames                 = (known after apply)
      + enable_dns_support                   = true
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "test_vpc"
        }
      + tags_all                             = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "test_vpc"
          + "Project"     = "SQS Lambda RDS Test"
        }
    }

  # module.sqs_lambda.module.dequeue_lambda_function.aws_cloudwatch_log_group.lambda[0] will be created
  + resource "aws_cloudwatch_log_group" "lambda" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + name              = "/aws/lambda/dequeue_function"
      + retention_in_days = 0
      + tags              = {
          + "Name" = "dev"
        }
      + tags_all          = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "dev"
          + "Project"     = "SQS Lambda RDS Test"
        }
    }

  # module.sqs_lambda.module.dequeue_lambda_function.aws_lambda_function.this[0] will be created
  + resource "aws_lambda_function" "this" {
      + architectures                  = (known after apply)
      + arn                            = (known after apply)
      + description                    = "Function to enqueue the request to the SQS queue"
      + filename                       = "builds/aeca8b627d0b0cbf187d14b01d6cd6165c06510e7dc6abf52f080e2c7f7fdecf.zip"
      + function_name                  = "dequeue_function"
      + handler                        = "index.lambda_handler"
      + id                             = (known after apply)
      + invoke_arn                     = (known after apply)
      + last_modified                  = (known after apply)
      + memory_size                    = 128
      + package_type                   = "Zip"
      + publish                        = false
      + qualified_arn                  = (known after apply)
      + reserved_concurrent_executions = -1
      + role                           = (known after apply)
      + runtime                        = "nodejs14.x"
      + signing_job_arn                = (known after apply)
      + signing_profile_version_arn    = (known after apply)
      + source_code_hash               = "1Uj84ezkme0Xpvxy0fdyV8A1KwbXfMQYMJyD0YQtb6Y="
      + source_code_size               = (known after apply)
      + tags                           = {
          + "Name" = "dev"
        }
      + tags_all                       = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "dev"
          + "Project"     = "SQS Lambda RDS Test"
        }
      + timeout                        = 3
      + version                        = (known after apply)

      + tracing_config {
          + mode = (known after apply)
        }
    }

  # module.sqs_lambda.module.dequeue_lambda_function.local_file.archive_plan[0] will be created
  + resource "local_file" "archive_plan" {
      + content              = jsonencode(
            {
              + artifacts_dir = "builds"
              + build_plan    = [
                  + [
                      + "zip",
                      + "./src/dequeue_function",
                      + null,
                    ],
                ]
              + filename      = "builds/aeca8b627d0b0cbf187d14b01d6cd6165c06510e7dc6abf52f080e2c7f7fdecf.zip"
              + runtime       = "nodejs14.x"
            }
        )
      + directory_permission = "0755"
      + file_permission      = "0644"
      + filename             = "builds/aeca8b627d0b0cbf187d14b01d6cd6165c06510e7dc6abf52f080e2c7f7fdecf.plan.json"
      + id                   = (known after apply)
    }

  # module.sqs_lambda.module.dequeue_lambda_function.null_resource.archive[0] will be created
  + resource "null_resource" "archive" {
      + id       = (known after apply)
      + triggers = {
          + "filename"  = "builds/aeca8b627d0b0cbf187d14b01d6cd6165c06510e7dc6abf52f080e2c7f7fdecf.zip"
          + "timestamp" = "1644181371776249000"
        }
    }

  # module.sqs_lambda.module.enqueue_lambda_function.aws_cloudwatch_log_group.lambda[0] will be created
  + resource "aws_cloudwatch_log_group" "lambda" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + name              = "/aws/lambda/enqueue_function"
      + retention_in_days = 0
      + tags              = {
          + "Name" = "dev"
        }
      + tags_all          = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "dev"
          + "Project"     = "SQS Lambda RDS Test"
        }
    }

  # module.sqs_lambda.module.enqueue_lambda_function.aws_lambda_function.this[0] will be created
  + resource "aws_lambda_function" "this" {
      + architectures                  = (known after apply)
      + arn                            = (known after apply)
      + description                    = "Function to enqueue the request to the SQS queue"
      + filename                       = "builds/584ce0a9df026caef51b1410a8019e086cd4816e00d6db80c479480923ef36f7.zip"
      + function_name                  = "enqueue_function"
      + handler                        = "index.lambda_handler"
      + id                             = (known after apply)
      + invoke_arn                     = (known after apply)
      + last_modified                  = (known after apply)
      + memory_size                    = 128
      + package_type                   = "Zip"
      + publish                        = false
      + qualified_arn                  = (known after apply)
      + reserved_concurrent_executions = -1
      + role                           = (known after apply)
      + runtime                        = "nodejs14.x"
      + signing_job_arn                = (known after apply)
      + signing_profile_version_arn    = (known after apply)
      + source_code_hash               = "zMBiJPTNXDFqKZUAvzSyNvGfeh0IC2B7jGiw/dR7ukw="
      + source_code_size               = (known after apply)
      + tags                           = {
          + "Name" = "dev"
        }
      + tags_all                       = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "dev"
          + "Project"     = "SQS Lambda RDS Test"
        }
      + timeout                        = 3
      + version                        = (known after apply)

      + tracing_config {
          + mode = (known after apply)
        }
    }

  # module.sqs_lambda.module.enqueue_lambda_function.local_file.archive_plan[0] will be created
  + resource "local_file" "archive_plan" {
      + content              = jsonencode(
            {
              + artifacts_dir = "builds"
              + build_plan    = [
                  + [
                      + "zip",
                      + "./src/enqueue_function",
                      + null,
                    ],
                ]
              + filename      = "builds/584ce0a9df026caef51b1410a8019e086cd4816e00d6db80c479480923ef36f7.zip"
              + runtime       = "nodejs14.x"
            }
        )
      + directory_permission = "0755"
      + file_permission      = "0644"
      + filename             = "builds/584ce0a9df026caef51b1410a8019e086cd4816e00d6db80c479480923ef36f7.plan.json"
      + id                   = (known after apply)
    }

  # module.sqs_lambda.module.enqueue_lambda_function.null_resource.archive[0] will be created
  + resource "null_resource" "archive" {
      + id       = (known after apply)
      + triggers = {
          + "filename"  = "builds/584ce0a9df026caef51b1410a8019e086cd4816e00d6db80c479480923ef36f7.zip"
          + "timestamp" = "1644181371777057800"
        }
    }

  # module.sqs_lambda.module.sqs-with-dlq.data.aws_iam_policy_document.deadletter_queue will be read during apply
  # (config refers to values not yet known)
 <= data "aws_iam_policy_document" "deadletter_queue"  {
      + id   = (known after apply)
      + json = (known after apply)

      + statement {
          + actions   = [
              + "sqs:ChangeMessageVisibility",
              + "sqs:DeleteMessage",
              + "sqs:GetQueueAttributes",
              + "sqs:GetQueueUrl",
              + "sqs:ListQueueTags",
              + "sqs:ReceiveMessage",
              + "sqs:SendMessage",
            ]
          + effect    = "Allow"
          + resources = [
              + (known after apply),
            ]

          + principals {
              + identifiers = [
                  + "663840385700",
                ]
              + type        = "AWS"
            }
        }
    }

  # module.sqs_lambda.module.sqs-with-dlq.data.aws_iam_policy_document.queue will be read during apply
  # (config refers to values not yet known)
 <= data "aws_iam_policy_document" "queue"  {
      + id   = (known after apply)
      + json = (known after apply)

      + statement {
          + actions   = [
              + "sqs:ChangeMessageVisibility",
              + "sqs:DeleteMessage",
              + "sqs:GetQueueAttributes",
              + "sqs:GetQueueUrl",
              + "sqs:ListQueueTags",
              + "sqs:ReceiveMessage",
              + "sqs:SendMessage",
            ]
          + effect    = "Allow"
          + resources = [
              + (known after apply),
            ]

          + principals {
              + identifiers = [
                  + "663840385700",
                ]
              + type        = "AWS"
            }
        }
    }

  # module.sqs_lambda.module.sqs-with-dlq.aws_cloudwatch_metric_alarm.alarm will be created
  + resource "aws_cloudwatch_metric_alarm" "alarm" {
      + actions_enabled                       = true
      + alarm_actions                         = (known after apply)
      + alarm_description                     = "The main_queue main queue has a large number of queued items"
      + alarm_name                            = "main_queue-flood-alarm"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + dimensions                            = {
          + "QueueName" = "main_queue"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "ApproximateNumberOfMessagesVisible"
      + namespace                             = "AWS/SQS"
      + period                                = 300
      + statistic                             = "Average"
      + tags                                  = {
          + "Environment" = "dev"
          + "Service"     = "main_queue"
        }
      + tags_all                              = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
          + "Service"     = "main_queue"
        }
      + threshold                             = 50
      + treat_missing_data                    = "notBreaching"
    }

  # module.sqs_lambda.module.sqs-with-dlq.aws_cloudwatch_metric_alarm.deadletter_alarm will be created
  + resource "aws_cloudwatch_metric_alarm" "deadletter_alarm" {
      + actions_enabled                       = true
      + alarm_actions                         = (known after apply)
      + alarm_description                     = "Items are on the main_queue-dead-letter-queue queue"
      + alarm_name                            = "main_queue-dead-letter-queue-not-empty-alarm"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + dimensions                            = {
          + "QueueName" = "main_queue-dead-letter-queue"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "ApproximateNumberOfMessagesVisible"
      + namespace                             = "AWS/SQS"
      + period                                = 300
      + statistic                             = "Average"
      + tags                                  = {
          + "Environment" = "dev"
          + "Service"     = "main_queue"
        }
      + tags_all                              = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
          + "Service"     = "main_queue"
        }
      + threshold                             = 1
      + treat_missing_data                    = "notBreaching"
    }

  # module.sqs_lambda.module.sqs-with-dlq.aws_sns_topic.alarm will be created
  + resource "aws_sns_topic" "alarm" {
      + arn                         = (known after apply)
      + content_based_deduplication = false
      + fifo_topic                  = false
      + id                          = (known after apply)
      + name                        = "main_queue-alarm-topic"
      + name_prefix                 = (known after apply)
      + owner                       = (known after apply)
      + policy                      = (known after apply)
      + tags_all                    = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
        }
    }

  # module.sqs_lambda.module.sqs-with-dlq.aws_sqs_queue.deadletter_queue will be created
  + resource "aws_sqs_queue" "deadletter_queue" {
      + arn                               = (known after apply)
      + content_based_deduplication       = false
      + deduplication_scope               = (known after apply)
      + delay_seconds                     = 0
      + fifo_queue                        = false
      + fifo_throughput_limit             = (known after apply)
      + id                                = (known after apply)
      + kms_data_key_reuse_period_seconds = 300
      + kms_master_key_id                 = "alias/aws/sqs"
      + max_message_size                  = 262144
      + message_retention_seconds         = 345600
      + name                              = "main_queue-dead-letter-queue"
      + name_prefix                       = (known after apply)
      + policy                            = (known after apply)
      + receive_wait_time_seconds         = 0
      + tags                              = {
          + "Environment" = "dev"
          + "Service"     = "main_queue"
        }
      + tags_all                          = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
          + "Service"     = "main_queue"
        }
      + url                               = (known after apply)
      + visibility_timeout_seconds        = 43200
    }

  # module.sqs_lambda.module.sqs-with-dlq.aws_sqs_queue.queue will be created
  + resource "aws_sqs_queue" "queue" {
      + arn                               = (known after apply)
      + content_based_deduplication       = false
      + deduplication_scope               = (known after apply)
      + delay_seconds                     = 0
      + fifo_queue                        = false
      + fifo_throughput_limit             = (known after apply)
      + id                                = (known after apply)
      + kms_data_key_reuse_period_seconds = 300
      + kms_master_key_id                 = "alias/aws/sqs"
      + max_message_size                  = 262144
      + message_retention_seconds         = 345600
      + name                              = "main_queue"
      + name_prefix                       = (known after apply)
      + policy                            = (known after apply)
      + receive_wait_time_seconds         = 0
      + redrive_policy                    = (known after apply)
      + tags                              = {
          + "Environment" = "dev"
          + "Service"     = "main_queue"
        }
      + tags_all                          = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Project"     = "SQS Lambda RDS Test"
          + "Service"     = "main_queue"
        }
      + url                               = (known after apply)
      + visibility_timeout_seconds        = 43200
    }

  # module.sqs_lambda.module.sqs-with-dlq.aws_sqs_queue_policy.deadletter_queue will be created
  + resource "aws_sqs_queue_policy" "deadletter_queue" {
      + id        = (known after apply)
      + policy    = (known after apply)
      + queue_url = (known after apply)
    }

  # module.sqs_lambda.module.sqs-with-dlq.aws_sqs_queue_policy.queue will be created
  + resource "aws_sqs_queue_policy" "queue" {
      + id        = (known after apply)
      + policy    = (known after apply)
      + queue_url = (known after apply)
    }

Plan: 26 to add, 0 to change, 0 to destroy.


------------------------------------------------------------------------
------------------------------------------------------------------------

```
</details>

## Observability (Bonus)
What things will you consider?

<details>
<summary>Summary</summary>

1. **Availability**
    * What: Check if the lambda services or the database are available
    * Why: Useful for fast detection and resolution of the problem 
2. **Error Rates**
    * What: Check any 5xx or 4xx HTTP status response from the services
    * Why: Important to detect security or code anomalies from the services
3. **Traffic**
    * What: Track the number of requests for each service
    * Why: Useful to detect high workload, security attacks (like DDOS), or even to measure the right resources for the architecture

</details>

## CICD Automation (Bonus)

This is the pipeline suggested by me for the main branch to deploy the application to the production environment. This pipeline should be triggered from a merge request from another branch. 

Numbered list = stages

Bullets = Jobs from the respective stage

1. **Pre**
    - Cache
    - Eslint
    - Prettier
2. **Build**
    - Build (container or the executable)
3. **Test**
    - Unit tests from the application
    - DAST
    - SAST
    - Container scanning
    - Dependencies scanning
    - (...) other tests suggested by the dev team
4. **Staging**
    - Deploy
5. **Production**
    - Deploy

For other branches I suggest a different workflow deploying to the Dev environment.


## Permissions (Bonus)

Example:

![alt text](/images/example_permissions.png "Permissions")

## Best Practices (Bonus)
Example of Best Practices
* Enable multi-factor authentication (MFA) for privileged users


## Disaster Recovery Plan (Bonus)

Example:

* Database Backup


## Compliance (Bonus)
Example:
* GDPR (data layer stored in EU-WEST)

## Migration

![alt text](https://cdn-images-1.medium.com/max/1600/0*WW36nabYAh5wn2v3. "Migration").

What Migration Strategy would you choose?

## App Migration Plan
Explain how would you do it

## Database Migration Plan
Explain how would you do it

## Budget (Bonus)

Calculation Report


# Next Steps

## Anything that we need to consider in the future?

