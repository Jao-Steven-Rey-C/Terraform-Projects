locals {
  project = "11-multiple-resources"

  ami_ids = {
    ubuntu = data.aws_ami.Ubuntu.id
    NGINX  = data.aws_ami.NGINX.id
  }
}