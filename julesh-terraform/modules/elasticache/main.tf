data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/vpc"
    region     = "ap-south-1"
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/kms"
    region     = "ap-south-1"
  }
}

resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name        = "${var.redis-cluster}-parameter-group"
  family      = var.parameter-group-family
  description = "Custom parameter group for ElastiCache Redis"

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

resource "aws_elasticache_user" "redis_user" {
  user_id   = var.redis-user-id
  user_name = var.redis-user-name
  engine    = "REDIS"
  passwords = [var.redis_password]  
  access_string = "on ~* +@all"  # Adjust access string as needed

  tags = {
    Name = "redis-user"
    Environment = var.environment
  }
}

resource "aws_elasticache_user_group" "redis_user_group" {
  user_group_id = "user-group-redis"
  engine        = var.redis-engine
  user_ids      = [aws_elasticache_user.redis_user.user_id]

  tags = {
    Name = "redis-user-group"
    Environment = var.environment
  }
}


resource "aws_elasticache_replication_group" "erg" {
  replication_group_id = var.replication-id
  description          = "Elasticache replication group"
  engine               = var.redis-engine
  engine_version       = var.redis-engine-version
  node_type            = var.redis-node-type
  #  num_cache_clusters            = var.num-cache-nodes
  num_node_groups            = var.num-node-groups # Ensure this is set correctly for cluster mode
  replicas_per_node_group    = var.replicas-per-node-group
  subnet_group_name          = aws_elasticache_subnet_group.eccr.name
  parameter_group_name       = aws_elasticache_parameter_group.redis_parameter_group.name
  security_group_ids         = [aws_security_group.elasticache_security_group.id]
  port                       = 6379
  at_rest_encryption_enabled = var.rest_encryption
  kms_key_id                 = data.terraform_remote_state.kms.outputs.key_arn
  transit_encryption_enabled = var.transit_encryption_enabled
#  transit_encryption_mode    = "preferred"
#  auth_token                 = var.auth_token
  automatic_failover_enabled = true
  user_group_ids = [aws_elasticache_user_group.redis_user_group.user_group_id]
  tags = {
    Name        = var.redis-cluster
    Environment = var.environment
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.redis-cluster
  replication_group_id = aws_elasticache_replication_group.erg.id
}
