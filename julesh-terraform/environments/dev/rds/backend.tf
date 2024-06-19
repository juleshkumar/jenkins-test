terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "backend/rds"
    region     = var.region
  }
}

