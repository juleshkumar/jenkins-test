output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.id
  #sensitive   = true
  description = "S3 Bucket Name"
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
  #sensitive   = true
  description = "AWS S3 Bucket ARN"
}
