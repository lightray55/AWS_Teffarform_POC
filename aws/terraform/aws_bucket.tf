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

# Make the bucket readable
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.b1.bucket

  index_document {
    suffix = "naughts_and_crosses.html"
  }

  error_document {
    key = ""
  }

  # Example routing rule that we don't need yet

  #routing_rule {
  #  condition {
  #    key_prefix_equals = "docs/"
  #  }
  #  redirect {
  #    replace_key_prefix_with = "documents/"
  #  }
  #}
}