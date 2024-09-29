data "aws_ami" "Ubuntu" {
  most_recent = true
  owners      = ["099720109477"] //Must be the resource owner's ID.

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "NGINX" {
  most_recent = true
  owners      = ["979382823631"] //Must be the resource owner's ID.

  filter {
    name   = "name"
    values = ["bitnami-nginx-1.25.4-*-linux-debian-12-x86_64-hvm-ebs-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "EC2-from-list" {
  count         = length(var.ec2_instance_config_list)                         //count = number of objects in ec2_instance_config_list.
  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami] //Accesses string objects in variable which matches string object in local.
  instance_type = var.ec2_instance_config_list[count.index].instance_type      //Accesses first item in variable list which is "t2.micro".

  subnet_id = aws_subnet.main[
    var.ec2_instance_config_list[count.index].subnet_name
  ].id //Equally distributes the 4 EC2's across the existing subnets in a Round Robin fashion.

  tags = {
    Project = local.project
    Name    = "${local.project}-${count.index}"
  }
}

resource "aws_instance" "EC2-from-map" {
  for_each      = var.ec2_instance_config_map   //for_each = number of objects in ec2_instance_config_map.
  ami           = local.ami_ids[each.value.ami] //Accesses string value from map.
  instance_type = each.value.instance_type      //Accesses first item in variable map which is "t2.micro".

  subnet_id = aws_subnet.main[each.value.subnet_name].id //Equally distributes the 4 EC2's across the existing subnets in a Round Robin fashion.

  tags = {
    Project = local.project
    Name    = "${local.project}-${each.key}"
  }
}