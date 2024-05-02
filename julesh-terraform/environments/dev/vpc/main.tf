module "vpc" {
  source         = "../../../modules/vpc"
  vpc_cidr       = var.vpc_cidr
  vpc_tags       = var.vpc_tags
  igw_tags       = var.igw_tags
#  azs            = var.azs
  environment    = var.environment
  security_group = var.security_group
  private-count  = var.private-count
  public-count   = var.public-count
  nat-count      = var.nat-count
  private-subnet_mask = var.private-subnet_mask
  public-subnet_mask  = var.public-subnet_mask
}
