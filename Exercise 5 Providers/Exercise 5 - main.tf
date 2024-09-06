resource "aws_s3_bucket" "local-bucket" {
  bucket = "my-bucket-12348765"
  //No provider required if you are deploying at the region you are currently at.
}

resource "aws_s3_bucket" "eu_west_1" {
  bucket   = "my-bucket-aosdhfoadhfu"
  provider = aws.Ireland //Specifies the provider from what region and uses the alias created in the providers config file.
}

resource "aws_s3_bucket" "us_east_1" {
  bucket   = "my-18736481364"
  provider = aws.us-east
}
