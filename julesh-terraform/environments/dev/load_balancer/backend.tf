terraform {
  backend "s3" {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/load"
    region     = "ap-south-1"
  }
}
