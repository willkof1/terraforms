resource "aws_s3_bucket" "example" {
  bucket        = var.bucketName
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://${var.domain_name}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.example.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "example-policy" {
  bucket     = aws_s3_bucket.example.id
  policy     = templatefile("templates/s3-policy.json", { bucket = var.bucketName })
  depends_on = [aws_s3_bucket_public_access_block.example]
}

resource "aws_s3_bucket_website_configuration" "example-config" {
  bucket = aws_s3_bucket.example.bucket
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "example-index" {
  bucket       = aws_s3_bucket.example.id
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
}

# s3 static website url

output "website_url" {
  value = "http://${aws_s3_bucket.example.bucket}.s3-website.${var.region}.amazonaws.com"
}
