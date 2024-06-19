terraform {
  backend "s3" {
    bucket   = var.backend_bucket
    key      = "backend/eks"
    region   = var.region
  }
}

