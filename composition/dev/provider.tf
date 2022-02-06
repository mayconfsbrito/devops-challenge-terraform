provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
  region                  = "us-west-1"

  default_tags {
    tags = {
      Project     = "SQS Lambda RDS Test"
      ManagedBy   = "Terraform"
      Environment = "dev"
    }
  }
}
