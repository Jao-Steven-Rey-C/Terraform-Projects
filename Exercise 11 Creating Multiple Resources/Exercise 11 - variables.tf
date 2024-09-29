variable "ec2_instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string //It is good practice to always specify the type of variable.
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only t2.micro and t3.micro instances are supported"
  }
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  default = []

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instances are allowed."
  }

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["ubuntu", "NGINX"], config.ami)
    ])
    error_message = "Only 'ubuntu' or 'NGINX' AMIs are allowed."
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instances are allowed."
  }

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "NGINX"], config.ami)
    ])
    error_message = "Only 'ubuntu' or 'NGINX' AMIs are allowed."
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "Invalid cidr_block(s) was entered."
  }
}