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

resource "aws_db_subnet_group" "vrt_subnet_group" {
  name        = "${var.vrt_db_instance_identifier}-subnet-group"
  description = "VRT RDS subnet group"
  subnet_ids  = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
}

resource "aws_security_group" "rds_security" {
  name        = var.vrt_db_security_group
  description = "VRT RDS PostgreSQL server"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.vrt_db_security_group}"
  }
}


// PgSQL can only be accessed from the WWW network (10.0.0.0/8)
resource "aws_security_group_rule" "vrt_ingress_rules" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [var.vrt__db_cidr_range]
  security_group_id = aws_security_group.rds_security.id
}



resource "aws_db_parameter_group" "vrt_database" {
  name        = "${var.vrt_db_instance_identifier}-param-group"
  description = "VRT parameter group for postgreSQL"
  family      = "postgres${var.major_version}"
  parameter {
    apply_method = "pending-reboot"
    name         = "max_connections"
    value        = "2000"
  }
}

resource "aws_db_instance" "vrt_database_instance" {
  identifier                = var.vrt_db_instance_identifier
  allocated_storage         = var.vrt_db_allocated_storage
  engine                    = "postgres"
  engine_version            = var.engine_version
  instance_class            = var.vrt_db_instance_type
  db_name                   = var.vrt_database_name
  username                  = var.database_user
  password                  = var.database_password
  db_subnet_group_name      = aws_db_subnet_group.vrt_subnet_group.name
  storage_encrypted         = true
  vpc_security_group_ids    = [aws_security_group.rds_security.id]
  storage_type              = "gp3"
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"
  parameter_group_name      = aws_db_parameter_group.vrt_database.name
  apply_immediately         = true
  kms_key_id = data.terraform_remote_state.kms.outputs.key_arn
}
