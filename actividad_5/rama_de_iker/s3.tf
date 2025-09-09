###############################
# Bucket S3 (rama_de_iker)
###############################

variable "region" {
	description = "Región AWS donde desplegar los recursos"
	type        = string
	default     = "us-east-1"
}

variable "bucket_prefix" {
	description = "Prefijo para el nombre del bucket (debe ser único globalmente si no se usa random)"
	type        = string
	default     = "iker-demo"
}

resource "random_id" "suffix" {
	byte_length = 4
}

locals {
	bucket_name = lower(replace("${var.bucket_prefix}-${random_id.suffix.hex}", "_", "-"))
}

resource "aws_s3_bucket" "this" {
	bucket = local.bucket_name

	tags = {
		Name        = local.bucket_name
		Owner       = "Iker"
		Environment = "dev"
		ManagedBy   = "Terraform"
	}
}

resource "aws_s3_bucket_versioning" "this" {
	bucket = aws_s3_bucket.this.id
	versioning_configuration {
		status = "Enabled"
	}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
	bucket = aws_s3_bucket.this.id
	rule {
		apply_server_side_encryption_by_default {
			sse_algorithm = "AES256"
		}
	}
}

resource "aws_s3_bucket_public_access_block" "this" {
	bucket                  = aws_s3_bucket.this.id
	block_public_acls       = true
	block_public_policy     = true
	ignore_public_acls      = true
	restrict_public_buckets = true
}

output "bucket_name" {
	description = "Nombre final del bucket creado"
	value       = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
	description = "ARN del bucket"
	value       = aws_s3_bucket.this.arn
}

