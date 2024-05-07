terraform {
  backend "s3" {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/efs"
    region     = "ap-south-1"
  }
}

