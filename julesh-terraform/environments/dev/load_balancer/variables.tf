variable "load_balancer_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "internal" {
  description = "Whether the load balancer is internal or not"
  type        = bool
}

variable "load_balancer_type" {
  description = "Type of load balancer (e.g., application)"
  type        = string
}

variable "lb_security_group" {
  type        = string
  description = "(optional) describe your variable"
}

variable "autoscaling-group-name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "target-group-name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "protocol" {
  type        = string
  description = "(optional) describe your variable"
}

variable "lb-port" {
  type        = number
  description = "(optional) describe your variable"
}

variable "from_ports" {
  type        = number
  description = "(optional) describe your variable"
}

variable "to_ports" {
  type        = number
  description = "(optional) describe your variable"
}

variable "security-group-cidr" {
  type        = string
  description = "(optional) describe your variable"
}

