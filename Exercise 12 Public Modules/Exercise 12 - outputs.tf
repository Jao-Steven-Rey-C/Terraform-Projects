output "all_info" {
  value = {
    available_azs          = data.aws_availability_zones.available_azs
    vpc_security_group_ids = module.vpc.default_security_group_id
    subnet_id              = module.vpc.public_subnets[*]
  }
}