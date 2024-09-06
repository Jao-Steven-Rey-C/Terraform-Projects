#This code should not be ran as it is only supposed to demonstrate all HCL blocks.
provider "aws" {}

resource "aws_s3_bucket" "my_bucket" { //Actively managed by us
  bucket = var.bucket_name
}

data "aws_s3_bucket" "my_external_bucket" { //Manages elsewhere. We just want to use this in our project
  bucket = "not-managed-by-us"
}

variable "bucket_name" { //
  type        = string
  description = "My variable used to set bucket name"
  default     = "my_default_bucket_name"
}

output "bucket_id" { //If you want the terminal to show a certain value.
  value = aws_s3_bucket.my_bucket.id
}

locals { //Temporary/Local Variables.
  local_example = "This is a local variable"
}

module "my_module" { //If you want to reference a module from another folder.
  source = "./module-example"
}