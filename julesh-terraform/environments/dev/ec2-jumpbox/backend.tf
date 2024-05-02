terraform {
  backend "s3" {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/jumpbox"
    region     = "us-east-1"
    role_arn   = "arn:aws:iam::471112548391:role/terraform-role"
  }
}
