output "all_buckets" {
  value = {
    local-bucket     = aws_s3_bucket.local-bucket.bucket
    eu_west_1-bucket = aws_s3_bucket.eu_west_1.bucket
    us_east_1-bucket = aws_s3_bucket.us_east_1.bucket
  }
}

