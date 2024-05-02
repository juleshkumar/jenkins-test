terraform {
  backend "s3" {
    bucket   = "terrafrom-test-to-delete-bucket"
    key      = "backend/vpc"
    region   = "ap-south-1"

    assume_role {
      role_arn = "arn:aws:iam::471112548391:role/terraform-role"
    }
  }
}
