terraform {
  backend "s3" {
    bucket   = ""
    key      = "backend/eks"
    region   = "us-east-1"
    role_arn = ""
  }
}

