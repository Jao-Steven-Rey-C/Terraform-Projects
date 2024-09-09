locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "Project 1 S3 Static Website"
  }
}

resource "random_string" "bucket_string" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "bucket-for-html" {
  bucket = "bucket-for-html-${random_string.bucket_string.id}"

  tags = merge(local.common_tags, {
    Name = "bucket-for-html"
  })
}

resource "aws_s3_bucket_public_access_block" "public_access_settings" {
  bucket = aws_s3_bucket.bucket-for-html.id

  block_public_acls       = false //True enables blocking, False allows access.
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_all_to_get" {
  bucket = aws_s3_bucket.bucket-for-html.id

  policy = jsonencode({    //Allows coding in JSON
    Version = "2012-10-17" //The latest version of JSON
    Statement = [{
      Sid       = "AllowAllToGet"
      Effect    = "Allow"
      Principal = "*"                                      //"*" means everyone and principal means to whom it will take effect to.
      Action    = "s3:GetObject"                           //Allows getting of objects in S3.
      Resource  = "${aws_s3_bucket.bucket-for-html.arn}/*" //The resource is the entire bucket.
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static_website_config" { //Recommended to be same name as project
  bucket = aws_s3_bucket.bucket-for-html.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.bucket-for-html.id
  key          = "index.html"
  source       = "html files/index.html"
  content_type = "html file" //describes format of object data
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.bucket-for-html.id
  key          = "error.html"
  source       = "html files/error.html"
  content_type = "html file"
}