
output "redis_parameter_group_name" {
  value = module.elasticache.redis_parameter_group_name
}

output "elasticache_security_group_id" {
  value = module.elasticache.elasticache_security_group_id
}

output "elasticache_subnet_group_name" {
  value = module.elasticache.elasticache_subnet_group_name
}

output "elasticache_cluster_id" {
  value = module.elasticache.elasticache_cluster_id
}

output "endpoint" {
  value = "${aws_elasticache_replication_group.erg.primary_endpoint_address}"
}




