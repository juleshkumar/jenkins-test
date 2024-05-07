terraform {
  backend "s3" {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/rds"
    region     = "ap-south-1"
  }
}

