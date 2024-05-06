terraform {
  backend "s3" {
    bucket   = "terrafrom-test-to-delete-bucket"
    key      = "backend/eks"
    region   = "ap-south-1"
  }
}

