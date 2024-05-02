variable "vrt_username" {
  type        = string
  description = "The name of the vrt user"
}

variable "iam_policy_arns" {
  type        = string
  description = "ARN of policy to be associated with the created IAM user"
}

