provider "aws" {
  region = "ca-central-1"
}

resource "aws_s3_bucket" "remote_backend_bucket" {
  bucket = "test-tf-remote-backend-bucket-111647882835674839238"
  tags = {
    Name        = "remote_backend_bucket"
  }
}

resource "aws_dynamodb_table" "remote_backend_table" {
  name           = "remote_backend_table"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"
  

  attribute {
    name = "LockID"
    type = "S"
  }
}