
variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
}


variable "max-workers-demand" {
  description = "Max number of eks worker instances that can be scaled."
  type        = string
}

variable "max-workers-spot" {
  description = "Max number of eks worker instances that can be scaled."
  type        = string
}
variable "cloudwatch_logs" {
  type        = bool
  description = "Setup full Cloudwatch logging."
}

variable "cluster-autoscaler" {
  type        = bool
  description = "Install k8s Cluster Autoscaler."
}

variable "instance_capacity_types_demand" {
  description = "EKS worker instance capacity types."
  type        = string
}

variable "instance_capacity_types_spot" {
  description = "EKS worker instance capacity types."
  type        = string
}

variable "inst_disk_size" {
  description = "EKS worker instance disk size in Gb."
  type        = string
}

variable "inst_key_pair" {
  description = "EKS worker instance ssh key pair."
  type        = string
}

variable "num-workers-spot" {
  description = "Number of eks worker instances to deploy."
  type        = string
}

variable "num-workers-demand" {
  description = "Number of eks worker instances to deploy."
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version."
  type        = string
}


variable "instance-type-on-demand" {
  description = "EKS worker instance type."
  type        = string
}

variable "instance-type-spot" {
  description = "EKS worker instance type."
  type        = string
}

variable "public_key_file" {
  type        = string
  description = "File path to the public key file"
}

variable "eks_key_name" {
  type = string
  description = "(optional) describe your variable"
}
