module "jumpbox" {
  source            = "../../../modules/ec2-jumpbox"
  ami               = var.ami
  public_key_file   = var.public_key_file
  ec2_instance_type = var.ec2_instance_type
  ec2_key_name      = var.ec2_key_name
  js_user           = var.js_user
  environment       = var.environment
  role              = var.role
  region            = var.region
  backend_bucket    = var.backend_bucket
  jumpbox_key       = var.jumpbox_key
  vpc_key = var.vpc_key
}
