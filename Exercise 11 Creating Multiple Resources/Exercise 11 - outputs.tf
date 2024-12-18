output "all_info" {
  value = {
    # length_subnet       = length(aws_subnet.main)
    ec2_from_list_count = length(var.ec2_instance_config_list)
  }
}