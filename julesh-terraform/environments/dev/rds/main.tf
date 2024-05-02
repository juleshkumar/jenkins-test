module "postgres" {
  source                     = "../../../modules/rds"
  major_version              = var.major_version
  engine_version             = var.engine_version
  vrt__db_cidr_range         = var.vrt__db_cidr_range
  vrt_database_name          = var.vrt_database_name
  vrt_db_allocated_storage   = var.vrt_db_allocated_storage
  vrt_db_instance_identifier = var.vrt_db_instance_identifier
  vrt_db_instance_type       = var.vrt_db_instance_type
  vrt_db_security_group      = var.vrt_db_security_group
  database_password          = var.database_password
  database_user              = var.database_user
}