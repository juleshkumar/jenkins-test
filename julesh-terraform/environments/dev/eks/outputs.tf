#eks
output "eks_cluster_id" {
  description = "The name of the cluster"
  #  value       = join("", aws_eks_cluster.eks.*.id)
  value = module.eks.eks_cluster_id
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  #  value       = join("", aws_eks_cluster.eks.*.arn)
  value = module.eks.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the Kubernetes API server"
  #  value       = join("", aws_eks_cluster.eks.*.endpoint)
  value = module.eks.eks_cluster_endpoint
}

output "eks_cluster_version" {
  description = "The Kubernetes server version of the cluster"
  #  value       = join("", aws_eks_cluster.eks.*.version)
  value = module.eks.eks_cluster_version
}




