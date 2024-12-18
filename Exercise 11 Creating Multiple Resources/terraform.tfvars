subnet_count = 2

subnet_configuration = {
  default = {
    cidr_block = "10.0.0.0/24"
  }
  cidr_block_1 = {
    cidr_block = "10.0.1.0/24"
  }
}

ec2_instance_count = 4

ec2_instance_config_list = [
  { instance_type = "t2.micro", ami = "ubuntu" },
  { instance_type = "t2.micro", ami = "nginx", subnet_name = "cidr_block_1" }
]

ec2_instance_config_map = {
  ubuntu = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  }

  nginx = {
    instance_type = "t2.micro"
    ami           = "nginx"
    subnet_name   = "cidr_block_1"
  }
}