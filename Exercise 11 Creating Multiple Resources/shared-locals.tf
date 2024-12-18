locals {
  vpc-name    = "Project-11-VPC"
  subnet-name = "Project-11-Subnet"
  ec2-name    = "Project-11-EC2"
  project     = "11-multiple-resources"

  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
    nginx  = data.aws_ami.nginx.id
  }
}