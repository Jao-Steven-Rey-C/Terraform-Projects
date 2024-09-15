/*variable "aws_region" {
  type        = string //It is good practice to always specify the type of variable.
  default     = "eu-west-3"
}*/

variable "ec2_instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only t2.micro and t3.micro instances are supported"
  }
}

variable "ec2_volume_config" {
  description = "The size and type of the root block volume for EC2 instances."

  type = object({ //Type of variable
    size = number
    type = string //Volume type for our EC2.
  })

  default = { //Default values
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  description = "Additional tags for our EC2 instance."

  type    = map(string)
  default = {}
}