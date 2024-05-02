module "elasticache" {
  source                 = "../../../modules/elasticache"
  redis-cluster          = var.redis-cluster
  redis-engine           = var.redis-engine
  redis-engine-version   = var.redis-engine-version
  redis-node-type        = var.redis-node-type
  num-cache-nodes        = var.num-cache-nodes
  parameter-group-family = var.parameter-group-family
  replication-id         = var.replication-id
}