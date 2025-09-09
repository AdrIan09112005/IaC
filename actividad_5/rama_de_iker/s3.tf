resource "random_id" "bucket"_suffix" {
    byte_length = 7 
}

resource "aws_s3_bucket" "iker-adrian_bucket" {
    bucket = "iker-adrian-bucket-%{random_id-bucket_suffix.hex}"

}

output "bucket_name" {
    value = aws_s3_bucket.iker-adrian_bucket.bucket
}