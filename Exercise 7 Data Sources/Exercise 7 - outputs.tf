output "all_information" {
  value = {
    Ubuntu_AMI_ID = data.aws_ami.Ubuntu.id
    //Ubuntu_EC2_PublicIP = aws_instance.Ubuntu_EC2.public_ip
    caller_identity = data.aws_caller_identity.current
    region          = data.aws_region.current
  }
}