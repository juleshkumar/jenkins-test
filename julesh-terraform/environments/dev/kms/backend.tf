terraform {
  backend "s3" {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/kms"
    region     = "ap-south-1"
  }
}

