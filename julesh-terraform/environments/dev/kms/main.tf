module "kms" {
  source       = "../../../modules/kms"
  kms_key_name = "eks-cluster-${var.kms_key_name}"
  backend_bucket     = var.backend_bucket
  region             = var.region

}
