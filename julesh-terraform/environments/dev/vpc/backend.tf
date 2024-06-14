terraform {
  backend "s3" {
    bucket     = var.AWS_BUCKET_NAME
    key      = "backend/vpc"
    region     = var.AWS_REGION
  }
}
