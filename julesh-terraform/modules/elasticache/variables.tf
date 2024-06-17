variable "redis-cluster" {
  type        = string
  description = "The ID of the ElastiCache cluster"
}

variable "redis-engine" {
  type        = string
  description = "The name of the cache engine to be used for the clusters in this replication group"
}

variable "redis-engine-version" {
  type        = string
  description = "The version number of the cache engine to be used for the cache clusters in this replication group"
}

variable "redis-node-type" {
  type        = string
  description = "The compute and memory capacity of the nodes in the node group"
}

#variable "num-cache-nodes" {
#  description = "The initial number of cache nodes that the cache cluster has"
#  type        = number
#}

variable "num-node-groups" {
  description = "The number of node groups (shards) for this Redis replication group"
  type        = number
}

variable "replicas-per-node-group" {
  description = "The number of replica nodes in each node group (shard)"
  type        = number
}

variable "parameter-group-family" {
  description = "The initial number of cache nodes that the cache cluster has"
  type        = string
}

variable "replication-id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "auth_token" {
  type = string
}

variable "rest_encryption" {
  type        = bool
  description = "(optional) describe your variable"
}

variable "environment" {
  type = string
}

variable "redis_password" {
  type = string
}

variable "redis-user-id" {
  type = string
}

variable "redis-user-name" {
  type = string
}

variable "transit_encryption_enabled" {
  type = bool
}
