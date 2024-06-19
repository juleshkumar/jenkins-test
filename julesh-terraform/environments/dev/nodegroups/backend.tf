terraform {
  backend "s3" {
    bucket   = var.backend_bucket
    key      = "backend/nodegroup"
    region   = var.region
  }
}
