terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias = "eu-central-1"
  region = "eu-central-1"
}


resource "aws_s3_bucket" "terraform_state" {
  provider = aws.eu-central-1
  bucket   = "bucket6718787hgv"
  acl    = "private"
 
  versioning {
    enabled = true
  }

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "Infrastructure"
  }
}
 
# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-table"
  provider = aws.eu-central-1
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
  tags = {
    Name        = "TerraformStateLockTable"
    Environment = "Infrastructure"
  }
}





