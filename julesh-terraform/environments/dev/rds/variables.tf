
variable "vrt_db_instance_identifier" {
  type        = string
  description = "Please mention the Database Instance Identifier"
}

variable "vrt_database_name" {
  type        = string
  description = "VRT Database Name"
}

variable "database_password" {
  type        = string
  description = "VRT Database Password"
}

variable "database_user" {
  type        = string
  description = "VRT Database Username"
}

variable "major_version" {
  type        = string
  description = "VRT Database Parameter Group Major Version"
}

variable "engine_version" {
  type        = string
  description = "VRT Database Engine Version"
}

variable "vrt_db_security_group" {
  type        = string
  description = "VRT Database Security Group"
}

variable "vrt_db_instance_type" {
  type        = string
  description = "VRT Database Instance Type"
}

variable "vrt_db_allocated_storage" {
  type        = string
  description = "VRT Database Storage Size"
}

variable "vrt__db_cidr_range" {
  type        = string
  description = "VRT CIDR Range"
}
