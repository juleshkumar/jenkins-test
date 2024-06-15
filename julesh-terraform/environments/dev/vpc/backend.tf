terraform {
  backend "s3" {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/jumpbox"
    region     = "ap-south-1"
  }
}
