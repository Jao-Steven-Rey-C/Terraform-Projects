# EC2
/*data "aws_ami" "Ubuntu" {
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
  ami           = data.aws_ami.Ubuntu.id
  instance_type = var.ec2_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config.size //gigabytes
    volume_type           = var.ec2_volume_config.type
  }

  tags = merge(var.additional_tags, local.common_tags, {
    Name = "Ubuntu_EC2"
  })
}*/

# S3
resource "random_string" "bucket_string" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = "${local.project}-${random_string.bucket_string.id}"

  tags = merge(var.additional_tags, local.common_tags)
}