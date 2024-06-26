#AWS Account Numbe
variable "public_key_file" {
  type        = string
  description = "File path to the public key file"
}

variable "ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "ec2_key_name" {
  type        = string
  description = "The name of the cluster"
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "js_user" {
  type        = string
  description = "jumpser username"
}

variable "environment" {
  type = string
}


variable "region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

