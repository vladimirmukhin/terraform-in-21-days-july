terraform {
  required_providers {
    aws = {}
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "terraform-remote-state-123123123"
    key            = "level2.tfstate"
    region         = "us-east-1"
    dynamodb_table = "state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}
