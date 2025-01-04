locals {
  project_name           = "object_validation"
  allowed_instance_types = ["t2.micro", "t3.micro"]
  CostCenter             = "1234"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Must be the resource owner's ID.

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "sample_EC2" {
  count         = 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main[count.index].id

  root_block_device {
    delete_on_termination = true
    volume_size           = 10 # gigabytes
    volume_type           = "gp3"
  }

  lifecycle {
    create_before_destroy = true

    # precondition { # Preconditions check the variable
    #     condition = contains(local.allowed_instance_types, var.instance_type) # Preconditions use var
    #     error_message = "Only t2.micro and t3.micro instances are allowed."
    # }
    postcondition {                                                              # while postconditions check the resource itself.
      condition     = contains(local.allowed_instance_types, self.instance_type) # while postconditions use self.
      error_message = "Only t2.micro and t3.micro instances are allowed."
    }
  }

  tags = {
    Name       = local.project_name
    Project    = local.project_name
    CostCenter = local.CostCenter
  }
}

check "cost_center_check" { # Check blocks don't lead to an error, just a warning. Good for configurations that are good to have but not critical.
  assert {
    condition     = alltrue([for instance in aws_instance.sample_EC2 : can(instance.tags.CostCenter != "")]) # Checks if all CostCenter tags is different than an empty string. If so, wars the user.
    error_message = "Your EC2 instance does not have a CostCenter tag."
  }
}