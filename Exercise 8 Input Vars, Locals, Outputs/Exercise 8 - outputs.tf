output "all_information" {
  value = {
    EC2_IP        = aws_instance.Ubuntu_EC2.public_ip
    Ubuntu_AMI_ID = data.aws_ami.Ubuntu.id
  }
}