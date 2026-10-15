# Accepted: practice bucket, no separate log bucket
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "sample_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "My Sample Bucket"
    Environment = "QA"
  }

}

resource "aws_s3_bucket_versioning" "sample_bucket_versioning" {
  bucket = aws_s3_bucket.sample_bucket.id
  count  = var.versioning_enabled ? 1 : 0

  versioning_configuration {
    status = "Enabled"
  }
}

# Accepted: practice bucket, AWS-managed AES256 is enough; a KMS key adds cost
#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "sample_bucket_encryption" {
  bucket = aws_s3_bucket.sample_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

resource "aws_s3_bucket_public_access_block" "sample_bucket_public_access" {
  bucket = aws_s3_bucket.sample_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



