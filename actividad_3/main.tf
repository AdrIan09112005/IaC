terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Providers
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "alan_server_terr" {
  ami           = "ami-0d1b5a8c13042c939"
  instance_type = "t3.micro"

  tags = {
    Name = "AlanServerTerraform"
  }
}

output "server_name" {
  value = aws_instance.alan_server_terr.tags.Name
}