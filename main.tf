terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "bucket6718787hgv"
    key            = "compute/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
 
provider "aws" {
  region = "us-east-1"
}

module "compute" {
  source      = "./compute"
 
}

module "networking" {
  source      = "./networking"
 
}
 
