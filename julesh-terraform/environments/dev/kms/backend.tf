terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "backend/kms"
    region     = var.region
  }
}

