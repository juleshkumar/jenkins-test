terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "backend/efs"
    region     = var.region
  }
}

