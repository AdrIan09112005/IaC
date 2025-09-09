terraform {
	required_version = ">= 1.5.0"
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = ">= 5.0"
		}
		random = {
			source  = "hashicorp/random"
			version = ">= 3.0"
		}
	}

	# IMPORTANTE: El bucket indicado en el backend debe existir previamente.
	# No intentes crearlo en el mismo plan que lo usa como backend.
	backend "s3" {
		bucket = "tf-remote-backend-0786" # eliminar espacio inicial
		key    = "state/actividad_5/terraform.tfstate"
		region = "us-east-2"
		encrypt = true
	}
}

provider "aws" {
	region = var.region
}


