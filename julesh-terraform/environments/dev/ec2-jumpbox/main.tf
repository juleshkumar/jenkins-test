module "jumpbox" {
  source            = "../../../modules/ec2-jumpbox"
  ami               = var.ami
  ec2_instance_type = var.ec2_instance_type
  ec2_key_name      = var.ec2_key_name
  js_user = var.js_user
}
