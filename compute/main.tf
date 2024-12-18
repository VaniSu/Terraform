terraform {
  backend "s3" {
    bucket         = "bucket6718787hgv"
    key            = "compute/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
