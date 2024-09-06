output "all_needed_information" {
  value = {
    vpc_id            = aws_vpc.ec2_vpc.id
    public_subnet_id  = aws_subnet.ec2_public_subnet.vpc_id
    private_subnet_id = aws_subnet.ec2_private_subnet.vpc_id
    igw_id            = aws_internet_gateway.ec2_igw.id
    public_rtb_id     = aws_route_table.public_rtb.id
    EC2_id            = aws_instance.sample-EC2.public_ip
  }
}
