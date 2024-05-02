terraform {
  backend "s3" {
    bucket     = ""
    key        = "backend/efs"
    region     = "us-east-1"
    role_arn   = ""
  }
}

