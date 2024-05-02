terraform {
  backend "s3" {
    bucket   = ""
    key      = "backend/nodegroup"
    region   = "us-east-1"
    role_arn = ""
  }
}