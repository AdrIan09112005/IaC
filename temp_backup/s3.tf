# actividad2/s3.tf
resource "aws_s3_bucket" "alan_bucket" {
  bucket = "alan-bucket-${random_id.suffix.hex}"

  tags = {
    Name        = "AlanBucket"
    Environment = "Dev"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_public_access_block" "alan_bucket_access" {
  bucket = aws_s3_bucket.alan_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.alan_bucket.bucket
}