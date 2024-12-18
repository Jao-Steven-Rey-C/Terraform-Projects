variable "subnet_count" {
  description = "Subnet Counter"
  type        = number
}

variable "subnet_configuration" {
  description = "Subnet Configuration"
  type = map(object({
    cidr_block = string
  }))

  validation {
    condition     = alltrue([for config in values(var.subnet_configuration) : can(cidrnetmask(config.cidr_block))])
    error_message = "One or more CIDR blocks are invalid."
  }
}

variable "ec2_instance_count" {
  description = "EC2 Counter"
  type        = number
}

variable "ec2_instance_config_list" {
  description = "EC2 configurations from list"
  type = list(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instance type is allowed."
  }

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only nginx and ubuntu ami's are allowed."
  }
}

variable "ec2_instance_config_map" {
  description = "EC2 configurations from map"
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instance type is allowed."
  }

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only nginx and ubuntu ami's are allowed."
  }
}