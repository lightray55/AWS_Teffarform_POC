locals {
  local_data = jsondecode(file(".env"))
}

provider "aws" {
  access_key = local.local_data.access_key
  secret_key = local.local_data.secret_key
  region     = "ap-southeast-2"
}

# Create a bucket
resource "aws_s3_bucket" "b1" {
  bucket = "bakker-app-test"
  acl    = "public-read"   # or can be "private"
  tags = {}
}

# Upload an object
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.b1.id
  key    = "naughts_and_crosses.html"
  acl    = "public-read"  # or can be "public-read"
  content_type = "text/html"
  source = "../../naughts_and_crosses.html"
  etag = filemd5("../../naughts_and_crosses.html")
}