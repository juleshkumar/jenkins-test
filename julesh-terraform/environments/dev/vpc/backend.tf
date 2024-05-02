terraform {
  backend "s3" {
    bucket   = ""
    key      = "backend/vpc"
    region   = "us-east-1"
    role_arn = ""
  }
}