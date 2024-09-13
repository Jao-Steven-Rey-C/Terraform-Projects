output "all_information" {
  value = {
    Ubuntu_AMI_ID = data.aws_ami.Ubuntu.id
    //Ubuntu_EC2_PublicIP = aws_instance.Ubuntu_EC2.public_ip
    caller_identity = data.aws_caller_identity.current
    current_region  = data.aws_region.current
    Oregon_region   = data.aws_region.Oregon
    prod_vpc_id     = data.aws_vpc.prod_vpc.id
    Available_AZs   = data.aws_availability_zones.available
    allow_get_JSON  = data.aws_iam_policy_document.allow_all_get.json //Outputs json of IAM policy.
  }
}