output "bucket_information" {
  value = {
    bucket-for-html-name         = aws_s3_bucket.bucket-for-html.bucket
    bucket-for-html-website-link = aws_s3_bucket.bucket-for-html.website_endpoint //Outputs the link to static website endpoint
  }
}