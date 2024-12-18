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

provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  provider      = aws.us-east-1
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_s3_bucket" "example" {
  provider = aws.eu-central-1
  bucket   = "bucket6718787hgv"

  tags = {
    Name        = "My bucket"
  }
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

terraform {
  backend "s3" {
    bucket         = "bucket6718787hgv"
    key            = "compute/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}



