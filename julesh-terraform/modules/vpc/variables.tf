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

variable "security_group" {
  type        = string
  description = "vpc security group"
}

variable "nat-count" {
  type        = number
  description = "Number of NAT gateways"
}

variable "public-count" {
  type        = number
  description = "Number of public subnets"
}

variable "private-count" {
  type        = number
  description = "Number of private subnets"
}

variable "public-subnet_mask" {
  type        = string
  description = "Subnet mask value for CIDR calculation"
}

variable "private-subnet_mask" {
  type        = string
  description = "Subnet mask value for CIDR calculation"
}
