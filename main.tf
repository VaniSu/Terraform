terraform {
  backend "s3" {
    bucket         = "bucket6718787hgv"
    key            = "networking/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
 
provider "aws" {
  region = "us-east-1"
}

module "backend" {
  source      = "https://github.com/VaniSu/Terraform/tree/main/backend"
 
}
 
# Module A
module "Compute" {
  source      = "https://github.com/VaniSu/Terraform/tree/main/compute"
  
}
 
# Module B
module "network" {
  source      = "https://github.com/VaniSu/Terraform/tree/main/networking"
 
}

