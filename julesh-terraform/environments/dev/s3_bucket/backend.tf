terraform {
  backend "s3" {
    bucket     = ""
    key        = "backend/s3"
    region     = "us-east-1"
    role_arn   = ""
  }
}

