provider "aws" {}

resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terrafor VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo-vpc.id
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}
