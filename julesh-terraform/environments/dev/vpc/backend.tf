terraform {
  backend "s3" {
    bucket   = "terrafrom-test-to-delete-bucket"
    key      = "backend/vpc"
    region   = "ap-south-1"
  }
}
