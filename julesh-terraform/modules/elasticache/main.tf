data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = "decimaltesting"
    key        = "backend/vpc"
    region     = "us-east-1"
    role_arn   = ""
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket     = "decimaltesting"
    key        = "backend/kms"
    region     = "us-east-1"
    role_arn   = ""
  }
}

resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name        = "${var.redis-cluster}-parameter-group"
  family      = var.parameter-group-family
  description = "Custom parameter group for ElastiCache Redis"

  parameter {
    name  = "hash-max-ziplist-entries"
    value = "512"
  }

  parameter {
    name  = "hash-max-ziplist-value"
    value = "64"
  }

#  parameter {
#    name  = "cluster-enabled"
#    value = "yes"
#  }

  # Add more parameters as needed
}

resource "aws_security_group" "elasticache_security_group" {
  name        = "${var.redis-cluster}-sg"
  description = "Security group for ElastiCache Redis cluster"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id # Assuming VPC ID is available from remote state data source

  # Ingress rule allowing access from specific subnets or security groups
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Adjust as needed to allow access from specific CIDR blocks
  }

  # Egress rule allowing outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_subnet_group" "eccr" {
  name       = "${var.redis-cluster}-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
}

resource "aws_elasticache_replication_group" "erg" {
  replication_group_id          = var.replication-id
  description                   = "Elasticache replication group"
  engine                        = var.redis-engine
  engine_version                = var.redis-engine-version
  node_type                     = var.redis-node-type
#  num_cache_clusters            = var.num-cache-nodes
  num_node_groups               = var.num-node-groups # Ensure this is set correctly for cluster mode
  replicas_per_node_group       = var.replicas-per-node-group
  subnet_group_name             = aws_elasticache_subnet_group.eccr.name
  parameter_group_name          = aws_elasticache_parameter_group.redis_parameter_group.name
  security_group_ids            = [aws_security_group.elasticache_security_group.id]
  port                          = 6379
  at_rest_encryption_enabled    = true
  kms_key_id                    = data.terraform_remote_state.kms.outputs.key_arn
  transit_encryption_enabled    = true
  auth_token                    = var.auth_token
  automatic_failover_enabled    = true
  tags = {
    Name = var.redis-cluster
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.redis-cluster
  replication_group_id = aws_elasticache_replication_group.erg.id
}
