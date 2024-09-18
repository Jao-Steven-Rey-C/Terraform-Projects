/*output "EC2_info" {
  EC2_IP        = aws_instance.Ubuntu_EC2.public_ip
  Ubuntu_AMI_ID = data.aws_ami.Ubuntu.id
}*/

output "s3_bucket_name" {
  sensitive   = true
  value       = aws_s3_bucket.project_bucket.id
  description = "The name of the S3 bucket" //Just a description.
}

output "sensitive_var" {
  sensitive = true   # Must be set to true since the variable is sensitive.
  value     = var.my_sensitive_value
}