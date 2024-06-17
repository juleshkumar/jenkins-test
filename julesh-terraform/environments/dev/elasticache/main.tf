module "elasticache" {
  source               = "../../../modules/elasticache"
  redis-cluster        = var.redis-cluster
  redis-engine         = var.redis-engine
  redis-engine-version = var.redis-engine-version
  redis-node-type      = var.redis-node-type
  #  num-cache-nodes        = var.num-cache-nodes
  parameter-group-family  = var.parameter-group-family
  replication-id          = var.replication-id
  auth_token              = var.auth_token
  num-node-groups         = var.num-node-groups
  replicas-per-node-group = var.replicas-per-node-group
  rest_encryption         = var.rest_encryption
  environment             = var.environment
  redis_password          = var.redis_password
  redis-user-id           = var.redis-user-id
  redis-user-name         = var.redis-user-name
  transit_encryption_enabled = var.transit_encryption_enabled
}
