output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
  #sensitive   = true
  description = "S3 Bucket Name"
}

output "s3_bucket_arn" {
  value = module.s3.s3_bucket_arn
  #sensitive   = true
  description = "AWS S3 Bucket ARN"
}
