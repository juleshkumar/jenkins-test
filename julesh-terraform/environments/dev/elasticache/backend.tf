terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "backend/ec"
    region     = var.region
  }
}

