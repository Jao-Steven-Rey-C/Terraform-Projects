resource "aws_default_vpc" "default" {}

data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "main" {
  count      = var.subnet_count
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.${128 + count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  # Distributes the subnets' across the available az's in a Round Robin fashion which is good practice.

  lifecycle {
    postcondition {
      condition     = contains(data.aws_availability_zones.available.names, self.availability_zone)
      error_message = "Invalid AZ."
    }
  }

  tags = {
    Name = "${local.project_name}_${count.index}"
  }
}

check "high_availability_check" {
  assert {
    condition     = length(toset([for subnet in aws_subnet.main : subnet.availability_zone])) > 1
    error_message = <<-EOT
    You are deploying all subnets in one AZ.
    Please make sure they are distributed across all AZs for high availability.
    EOT
  }
}