locals {
  cidr       = "10.0.0.0/16"
  private_SN = ["10.0.0.0/24"]
  public_SN  = ["10.0.128.0/24"]
}

data "aws_availability_zones" "available_azs" {}

module "vpc" {                              # Name can be any. Must run "terraform init" after creating modules.
  source  = "terraform-aws-modules/vpc/aws" # "source" and "version" are obtained from the respective module under "Provision Instructions".
  version = "5.5.3"                         # This version will be used for this lesson's purpose.

  cidr            = local.cidr
  name            = local.project
  azs             = data.aws_availability_zones.available_azs.names
  private_subnets = local.private_SN
  public_subnets  = local.public_SN

  tags = local.common_tags
}

/*
As you can see, when running "terraform plan", 12 resources are about to be created. A LOT is happening behind the scenes. This shows how powerful
using modules is! This makes the job of cloud IaC developers easier because you don't need to know the internals of how VPC's work. This makes it
advisable to only use a resource's module when very familiar with it and to always inspect the changes before applying. However, when you are
already an expert, then feel free to leverage modules so they can take care of the management for you.
*/