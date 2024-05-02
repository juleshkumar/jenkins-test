terraform {
  backend "s3" {
    bucket     = ""
    key        = "<path-of-your-backend>/account"
    region     = ""
    role_arn   = ""
  }
}