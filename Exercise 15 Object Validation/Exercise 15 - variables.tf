variable "subnet_count" {
  description = "The number of subnets."
  type        = number
  default     = 4
}

variable "instance_type" {
  description = "The instance type of our EC2 instance."
  type        = string
  default     = "t2.micro"
}