terraform {
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

module "compute" {
  source      = "./compute"
 
}

module "networking" {
  source      = "./networking"
 
}
 
