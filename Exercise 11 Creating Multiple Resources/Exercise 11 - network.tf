resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Project = local.project
    Name    = local.project
  }
}

resource "aws_subnet" "main" {
  //count      = var.subnet_count //If from list.
  for_each = var.subnet_config //If from map.
  vpc_id   = aws_vpc.main.id
  //cidr_block = "10.0.${count.index}.0/24" //If from list. Starts counting from 0 up to count's value.
  cidr_block = each.value.cidr_block //If from map.

  tags = {
    Project = local.project
    //Name    = "${local.project}-${count.index}" //If from list.
    Name = "${local.project}-${each.key}" //If from map.
  }
}