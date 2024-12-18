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
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_internet_gateway" "int_gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "InternetGateway"
  }
}



resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int_gw.id
  }

  tags = {
    Name = "PubRouteTable"
  }
}

resource "aws_route_table" "pri_rt" {
  vpc_id = aws_vpc.vpc.id


  tags = {
    Name = "PriRouteTable"
  }
}


resource "aws_route_table_association" "public_sb_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pri_sb_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.pri_rt.id
}
