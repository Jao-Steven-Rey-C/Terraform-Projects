terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6" # Note: Terraform version 5.8.1 now requires password output to be marked as "sensitive."
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}