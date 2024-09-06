terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6"
    }
  }
}

//provider "aws" {}

provider "aws" {
  region = "eu-west-1"
  alias  = "Ireland"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east"
}
