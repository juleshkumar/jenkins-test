terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "backend/load"
    region     = var.region
  }
}
