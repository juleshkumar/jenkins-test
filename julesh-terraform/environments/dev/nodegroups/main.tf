module "nodegroup" {
  source = "../../../modules/nodegroup"
  cloudwatch_logs                = var.cloudwatch_logs
  inst_key_pair                  = var.inst_key_pair
  inst_disk_size                 = var.inst_disk_size
  instance-type-on-demand        = var.instance-type-on-demand
  instance-type-spot             = var.instance-type-spot
  instance_capacity_types_demand = var.instance_capacity_types_demand
  instance_capacity_types_spot   = var.instance_capacity_types_spot
  max-workers-demand             = var.max-workers-demand
  max-workers-spot               = var.max-workers-spot
  cluster-autoscaler             = var.cluster-autoscaler
  cluster-name                   = var.cluster-name
  num-workers-demand             = var.max-workers-demand
  num-workers-spot               = var.max-workers-spot
  public_key_file                = var.public_key_file
  eks_key_name                   = var.eks_key_name
}