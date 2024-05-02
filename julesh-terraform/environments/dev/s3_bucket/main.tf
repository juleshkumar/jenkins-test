module "s3" {
  source            = "../../../modules/s3_bucket"
  s3-bucket         = var.s3-bucket
  bucket-versioning = var.bucket-versioning
  block_public_acls   = var.block_public_acls
  block_public_policy = var.block_public_policy
  ignore_public_acls  = var.ignore_public_acls
}