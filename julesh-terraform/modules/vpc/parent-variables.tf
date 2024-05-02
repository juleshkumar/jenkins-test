# vpc/variables.tf

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
}

variable "igw_tags" {
  description = "Tags for the IGW"
  type        = map(string)
}

variable "environment" {
  type        = string
  description = "environment for vpc"
}

#variable "azs" {
#  type        = string
#  description = "availability zones"
#}

variable "security_group" {
  type        = string
  description = "vpc security group "
}

variable "nat-count" {
  type        = number
  description = "vpc security group "
}


variable "public-count" {
  type        = number
  description = "vpc public subnet count group "
}

variable "private-count" {
  type        = number
  description = "vpc public subnet count group "
}

variable "public-subnet_mask" {
  type        = number
  description = "Subnet mask value for CIDR calculation"
}

variable "private-subnet_mask" {
  type        = number
  description = "Subnet mask value for CIDR calculation"

}

