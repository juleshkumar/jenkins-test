

output "spot_node_group_name" {
  value = module.nodegroup.spot_node_group_name
}

output "demand_node_group_name" {
  value = module.nodegroup.demand_node_group_name
}

output "spot_instance_types" {
  value = module.nodegroup.spot_instance_types
}

output "demand_instance_types" {
  value = module.nodegroup.demand_instance_types
}

output "spot_remote_access" {
  value = module.nodegroup.spot_remote_access
}

output "demand_remote_access" {
  value = module.nodegroup.demand_remote_access
}
