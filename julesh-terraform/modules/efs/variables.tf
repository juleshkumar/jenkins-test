variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
}

variable "efs-security-group" {
  description = "The name of the cluster"
  type        = string
}

variable "region" {
  type = string
}

variable "backend_bucket" {
  type = string
}
