# variable "aws_iam_info" {}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
  region                  = "us-west-1"
}
