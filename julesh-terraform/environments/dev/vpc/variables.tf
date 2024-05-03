variable "vpc_cidr" {
  type        = string
  description = "vpc for all resources"
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = {
    Name = "test-vpc"
  }
}

variable "igw_tags" {
  description = "Tags for the Internet Gateway"
  type        = map(string)
  default     = {
    Name = "test-igw"
  }
}

variable "environment" {
  type        = string
  description = "environment for vpc"
}

#variable "azs" {
#  type        = string
#  description = "(optional) describe your variable"
#}

variable "security_group" {
  type        = string
  description = "(optional) describe your variable"
}

variable "public-count" {
  type        = number
  description = "vpc public subnet count group "
}

variable "private-count" {
  type        = number
  description = "vpc public subnet count group"
}


variable "nat-count" {
  type        = number
  description = "vpc security group "
}

variable "public-subnet_mask" {
  type        = number
  description = "Subnet mask value for CIDR calculation"
}

variable "private-subnet_mask" {
  type        = number
  description = "Subnet mask value for CIDR calculation"
}

