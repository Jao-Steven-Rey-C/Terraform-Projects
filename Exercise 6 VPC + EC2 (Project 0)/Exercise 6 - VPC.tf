locals { //"Local" must be plural but when calling, must be singular.
  common_tags = {
    ManagedBy = "Terraform"
    Exercise  = "Exercise 6 VPC + EC2"
  }
}

resource "aws_vpc" "ec2_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, { //This is how you merge common and unique tags.
    Name = "EC2 VPC"
  })
}

resource "aws_subnet" "ec2_public_subnet" {
  vpc_id     = aws_vpc.ec2_vpc.id
  cidr_block = "10.0.7.0/24"

  tags = merge(local.common_tags, {
    Name = "EC2 public_subnet"
  })
}

resource "aws_subnet" "ec2_private_subnet" {
  vpc_id     = aws_vpc.ec2_vpc.id
  cidr_block = "10.0.8.0/24"

  tags = merge(local.common_tags, {
    Name = "EC2 private_subnet"
  })
}

resource "aws_internet_gateway" "ec2_igw" {
  vpc_id = aws_vpc.ec2_vpc.id

  tags = merge(local.common_tags, {
    Name = "EC2 igw"
  })
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.ec2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2_igw.id
  }

  tags = merge(local.common_tags, {
    Name = "EC2 rtb"
  })
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.ec2_public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_security_group" "eighty_and_fourfourthree" {
  name        = "eighty_and_fourfourthree"
  description = "Allows HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.ec2_vpc.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0 //0 means all ports
    to_port     = 0
    protocol    = "-1" //-1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "eighty_and_fourfourthree"
  })
}
