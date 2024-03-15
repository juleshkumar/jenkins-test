variable "name" {
  default     = "Default"
  type        = string
  description = "Test VPC"
}

variable "project" {
  type        = string
  description = "Testing"
  default     = "Testing"
}

variable "environment" {
  type        = string
  description = "dev"
  default     = "Testing"   
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

variable "public1_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24"]
  type        = string
  description = "List of public 1 subnet CIDR blocks"
}

variable "public2_subnet_cidr_blocks" {
  default     = [ "10.0.2.0/24"]
  type        = string
  description = "List of public 2 subnet CIDR blocks"
}

variable "private1_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24"]
  type        = string
  description = "List of private subnet CIDR blocks"
}

variable "private2_subnet_cidr_blocks" {
  default     = [ "10.0.3.0/24"]
  type        = string
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones1" {
  default     = ["ap-south-1a"]
  type        = string
  description = "List of availability zones 1"
}

variable "availability_zones2" {
  default     = [ "ap-south-1b"]
  type        = string
  description = "List of availability zones 2"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "dev"
}
