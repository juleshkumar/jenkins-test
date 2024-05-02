terraform {
  backend "s3" {
    bucket     = ""
    key        = "backend/ec"
    region     = "us-east-1"
    role_arn   = ""
  }
}

