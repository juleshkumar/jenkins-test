terraform {
  backend "s3" {
    bucket     = var.backend_bucket
    key        = "backend/jumpbox"
    region     = var.region
  }
}
