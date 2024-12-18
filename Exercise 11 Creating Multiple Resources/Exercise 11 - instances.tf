data "aws_ami" "ubuntu" {
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

data "aws_ami" "nginx" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-nginx-1.25.4-*-linux-debian-12-x86_64-hvm-ebs-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# resource "aws_instance" "Multiple_EC2-from_count" {
#   count         = var.ec2_instance_count
#   ami           = data.aws_ami.Ubuntu.id
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id

#   tags =  {
#     Name    = "${local.ec2-name}-${count.index}"
#     Project = local.project
#   }
# }

# resource "aws_instance" "Multiple_EC2-from_list" {
#   count         = length(var.ec2_instance_config_list)
#   ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
#   instance_type = var.ec2_instance_config_list[count.index].instance_type
#   subnet_id = aws_subnet.from_map[
#     var.ec2_instance_config_list[count.index].subnet_name
#   ].id

#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name    = "${local.ec2-name}-${var.ec2_instance_config_list[count.index].ami}"
#     Project = local.project
#   }
# }

resource "aws_instance" "Multiple_EC2-from_map" {
  for_each      = var.ec2_instance_config_map 
  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.from_map[each.value.subnet_name].id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name    = "${local.ec2-name}-${each.key}"
    Project = local.project
  }
}