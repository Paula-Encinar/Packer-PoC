resource "aws_s3_bucket" "packer_manifest" {
  bucket = "packer-manifest"
  force_destroy = true

  tags = {
    Name        = "packer-manifest"
    Environment = "Development"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership_controls" {
  bucket = aws_s3_bucket.packer_manifest.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "packer_manifest" {
  bucket = aws_s3_bucket.packer_manifest.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "packer_manifest" {
  bucket = aws_s3_bucket.packer_manifest.id
  versioning_configuration {
    status = "Enabled"
  }
}