terraform {
  backend "s3" {
    bucket   = ""
    key      = "backend/eks"
    region   = "ap-south-1"
  }
}

