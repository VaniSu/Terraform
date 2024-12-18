resource "aws_s3_bucket" "terraform_state" {

  bucket   = "bucket6718787hgv"
  acl      = "private"
 
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
