variable "s3-bucket" {
  description = "s3 bucket vrt"
  type        = string
}

variable "bucket-versioning" { #added newly
  description = "versioning of the s3"
  type        = string
}

#variable "bucket-acl" {   #added newly
#  description = "versioning of the s3"
#  type        = string
#}

variable "block_public_acls" {
  description = "Whether the s3 acl is public or not"
  type        = bool
}

variable "block_public_policy" {
  description = "Whether the s3 policy is public or not"
  type        = bool
}

variable "ignore_public_acls" {
  description = "Whether to ignore public acl or not"
  type        = bool
}

variable "iam_s3_bucket_policy" {
  description = "Name for the VRT IAM s3 Bucket policy"
  type        = string
  default     = "vrt-s3-bucket-policy"
}