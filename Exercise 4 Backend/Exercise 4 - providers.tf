terraform {
  required_version = "~> 1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" { //To store some item into your AWS account's S3.
    bucket = "state-bucket-202100881"
    key    = "Exercise 4 Backend/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
