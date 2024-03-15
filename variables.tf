# vpc/variables.tf

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"


}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = "vpc-dev"
}

variable "igw_tags" {
  description = "Tags for the IGW"
  type        = map(string)
  default     = "igw-dev"
}

variable "environment" {
  type        = string
  description = "environment for vpc"
  default     = "dev"
}

variable "azs" {
  type        = list(string)
  description = "availability zones"
  default     = "ap-south-1a", "ap-south-1b", "ap-south-1c"
}

variable "security_group" {
  type        = string
  description = "vpc security group "
  default     = "vpc-sg"
}

variable "nat-count" {
  type        = number
  description = "vpc security group "
  default     = "4"
  
}


variable "public-count" {
  type        = number
  description = "vpc public subnet count group "
  default     = "2"
}

variable "private-count" {
  type        = number
  description = "vpc public subnet count group "
  default     = "2"
}

variable "public-subnet_mask" {
  type        = number
  description = "Subnet mask value for CIDR calculation"
  default     = "4"
}

variable "private-subnet_mask" {
  type        = number
  description = "Subnet mask value for CIDR calculation"
  default     = "4"

}
