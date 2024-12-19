terraform {
  backend "s3" {
    bucket         = "bucket6718787hgv"
    key            = "compute/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
