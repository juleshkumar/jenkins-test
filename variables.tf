variable "name" {
  default     = "test-vpc"
  type        = string
  description = "Name of the VPC"
}

variable "project" {
  default     = "testing"
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  default     = "dev"
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "region" {
  default     = "ap-south-1"
  type        = string
  description = "Region of the VPC"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "availability_zone_one" {
  default     = "ap-south-1a"
  type        = string
  description = "List of availability zone 1"
}

variable "availability_zone_two" {
  default     = "ap-south-1b"
  type        = string
  description = "List of availability zone 2"
}

variable "public_subnet_a_cidr_blocks" {
  default     = "10.0.0.0/24"
  type        = string
  description = "public subnet 1a CIDR blocks"
}

variable "public_subnet_b_cidr_blocks" {
  default     = "10.0.1.0/24"
  type        = string
  description = "public subnet 1b CIDR blocks"
}

variable "private_subnet_a_cidr_blocks" {
  default     = "10.0.2.0/24"
  type        = string
  description = "private subnet 1a CIDR blocks"
}

variable "private_subnet_b_cidr_blocks" {
  default     = "10.0.3.0/24"
  type        = string
  description = "private subnet 1b CIDR blocks"
}
