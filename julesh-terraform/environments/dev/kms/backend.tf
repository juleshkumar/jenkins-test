terraform {
  backend "s3" {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/kms"
    region     = "us-east-1"
  }
}

