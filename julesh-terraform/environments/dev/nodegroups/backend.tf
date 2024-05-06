terraform {
  backend "s3" {
    bucket   = "terrafrom-test-to-delete-bucket"
    key      = "backend/nodegroup"
    region   = "ap-south-1"
  }
}
