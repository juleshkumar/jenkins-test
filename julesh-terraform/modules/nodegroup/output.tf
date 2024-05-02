
output "spot_node_group_name" {
  value = aws_eks_node_group.spot.node_group_name
}

output "demand_node_group_name" {
  value = aws_eks_node_group.on_demand.node_group_name
}

output "spot_instance_types" {
  value = aws_eks_node_group.spot.instance_types
}

output "demand_instance_types" {
  value = aws_eks_node_group.on_demand.instance_types
}

output "spot_remote_access" {
  value = aws_eks_node_group.spot.remote_access
}

output "demand_remote_access" {
  value = aws_eks_node_group.on_demand.remote_access
}
