#azs = ["us-east-1a", "us-east-1b"]

#azs = length(data.aws_availability_zones.available.names)

vpc_cidr = "10.0.0.0/16"

vpc_tags = {
    Name = "vpc-dev"
}

igw_tags ={
    Name = "igw-dev"
}

public-count = 2

private-count = 2

nat-count = 2

public-subnet_mask = 4

private-subnet_mask = 4

environment = "dev"

region = "us-east-1"

internal = false

load_balancer_type = "application"

load_balancer_name = "decimal-load-balancer"

security_group = "vpc-sg"

lb-port = 80

protocol = "HTTP"

autoscaling-group-name = "vrt-asg"

target-group-name = "tg-sg-lb"

lb_security_group = "load-balancer-sg"

from_ports = 443

to_ports = 443

security-group-cidr = "0.0.0.0/0"

kms_key_name = "decimal-kms-key"

sub_account_name = "VRT-Autmation"

client_email = ""

cluster-name = "eks-decimal-test"

max-workers-demand = "5"

max-workers-spot = "5"

cloudwatch_logs = false

cluster-autoscaler = false

instance_capacity_types_demand = "ON_DEMAND"

instance_capacity_types_spot = "SPOT"

inst_disk_size = "60"

inst_key_pair = null

num-workers-spot ="1"

num-workers-demand = "1"

k8s_version = "1.29"

instance-type-on-demand = "r5a.large"

instance-type-spot = "t3a.large"

public_key_file= "~/.ssh/id_rsa.pub"

ami = "ami-0f403e3180720dd7e"

ec2_key_name = "jumpbox-key-ec2"

ec2_instance_type = "t2.micro"

s3-bucket = "decimal-bucket-test"

bucket-versioning = "Enabled"

block_public_acls = false

block_public_policy = false

ignore_public_acls = false

iam_s3_bucket_policy = "decimal-s3-bucket-policy"

vrt_db_instance_identifier = "decimal-db-tech"

vrt_db_security_group = "decimal-rds-security"

vrt__db_cidr_range = "10.34.0.0/16"

major_version = "12"

vrt_db_allocated_storage = "20"

engine_version = "12.12"

vrt_db_instance_type = "db.m6g.large"

vrt_database_name = "decimal_database_technologies"

database_user = "psq_demo"

database_password = "Qwerty#789"

efs-security-group = "efs-mount-target-sg"

replication-id = "decimal-elasticache-replication"

redis-cluster = "elasticache-redis-cluster"

redis-engine = "redis"

redis-engine-version = "6.0"

redis-node-type = "cache.t3.small"

num-cache-nodes = "1"

parameter-group-family = "redis6.x"

vrt_username = "decimal-developer"

iam_policy_arns = "arn:aws:iam::aws:policy/ReadOnlyAccess"

js_user = "ec2-js-user"

eks_key_name = "eks-key"