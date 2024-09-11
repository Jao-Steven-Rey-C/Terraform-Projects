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

resource "aws_instance" "Ubuntu_EC2" {
  associate_public_ip_address = true
  ami                         = data.aws_ami.Ubuntu.id
  instance_type               = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 10 //gigabytes
    volume_type           = "gp3"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Ubuntu_EC2"
  }
}