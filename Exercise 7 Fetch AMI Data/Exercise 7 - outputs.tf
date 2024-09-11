output "all_needed_information" {
  value = {
    Ubuntu-EC2_IP = aws_instance.Ubuntu-EC2.public_ip
    AMI_id        = data.aws_ami.ubuntu.id
  }
}