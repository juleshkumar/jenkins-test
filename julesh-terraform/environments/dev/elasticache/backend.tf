terraform {
  backend "s3" {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/ec"
    region     = "ap-south-1"
  }
}

