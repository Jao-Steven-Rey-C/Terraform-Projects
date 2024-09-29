ec2_instance_config_list = [
  /*{ instance_type = "t2.micro", ami = "ubuntu" },
  { instance_type = "t2.micro", ami = "NGINX" }*/
]

ec2_instance_config_map = {
  ubuntu = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  }

  NGINX = {
    instance_type = "t2.micro"
    ami           = "NGINX"
    subnet_name   = "subnet_1"
  }
}

subnet_config = {
  default = {
    cidr_block = "10.0.0.0/24"
  }

  subnet_1 = {
    cidr_block = "10.0.1.0/24"
  }
}