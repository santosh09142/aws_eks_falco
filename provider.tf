# provider for AWS connect
terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

provider "aws" {
  region = var.region #"us-east-1"
}
# provider for AWS
