data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_region" "Oregon" {
  provider = aws.Oregon //If you want to return data from another region.
}

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

data "aws_vpc" "prod_vpc" { //Finds an existing VPC whose tag's Env value is "Prod".
  tags = {
    Env = "Prod"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_policy_document" "allow_all_get" {
  statement {
    sid = "allow_all_to_get"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = [
      "arn:aws:s3:::*/*", //This is very permissive. Don't do this.
    ]
  }
}

/*resource "aws_instance" "Ubuntu_EC2" {
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
}*/