resource "aws_instance" "sample-EC2" {
  ami = "ami-04f7705bc67eb8211" //AMI is rapidly changing so it must be variable not hardcoded. Use an architecture that
  //matches your computer's.
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.ec2_public_subnet.id //Places EC2 inside a subnet.

  #It is good practice to delete root block device (rbd) upon termination though rbd is not req'd.
  root_block_device {
    delete_on_termination = true
    volume_size           = 10 //gigabytes
    volume_type           = "gp3"
  }
  vpc_security_group_ids = [aws_security_group.eighty_and_fourfourthree.id] //This EC2 belongs inside a VPC so it must use this syntax when using
  //a security group.

  lifecycle {
    create_before_destroy = true //When changing something in an EC2, it is good practice to create a new one first before destroying the old 
    //one to avoid downtime.
    //ignore_changes = [tags] //Ignores any change on the tags via the AWS console. 
  }

  tags = merge(local.common_tags, {
    Name = "Sample EC2"
  })
}