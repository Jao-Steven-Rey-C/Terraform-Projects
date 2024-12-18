resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = local.vpc-name
    Project = local.project
  }
}

# resource "aws_subnet" "main" {
#   count      = var.subnet_count
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.${count.index}.0/24"

#   tags = {
#     Name    = "${local.subnet-name}-${count.index}"
#     Project = local.project
#   }
# }

resource "aws_subnet" "from_map" {
  for_each   = var.subnet_configuration
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block

  tags = {
    Name    = "${local.subnet-name}-${each.key}"
    Project = local.project
  }
}