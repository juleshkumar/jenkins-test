terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "backend/vpc"
    region     = var.region
  }
}
