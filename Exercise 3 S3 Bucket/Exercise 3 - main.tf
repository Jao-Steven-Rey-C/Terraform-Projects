resource "random_string" "bucket_string" {
  length  = 8
  special = false //Prevents special characters which is prohibited in naming S3 buckets.
  upper   = false //Prevents uppercase letters which is prohibited in naming S3 buckets.
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-${random_string.bucket_string.id}"

  tags = {
    Name        = "example-bucket"
    Environment = "Dev"
    MadeBy      = "Steven Rey Jao"
  }
}
