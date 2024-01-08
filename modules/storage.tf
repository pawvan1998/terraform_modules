resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.cloud_env}-${var.bucket_name}"
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

/*
resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = var.bucket_acl
}*/