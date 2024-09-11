data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] //Must be the owner id of the resource.

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

resource "aws_instance" "Ubuntu-EC2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 10 //gigabytes
    volume_type           = "gp3"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Ubuntu-EC2"
  }
}