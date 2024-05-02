# VRT Username:
output "vrt_username" {
  description = "IAM based VRT Username."
  value       = aws_iam_user.vrt_user.id
}

# VRT user Acess Keys and Secret Keys
output "vrt_access_keys" {
  description = "VRT IAM Access Keys"
  value       = aws_iam_access_key.vrt_iam_keys.id
}

## VRT User Policy ARN
output "vrt_policy_arn" {
  description = "VRT User Policy ARN"
  value       = aws_iam_user_policy_attachment.attach_vrt_user.id
}

output "vrt_secret_keys" {
  description = "VRT IAM Secret Keys"
  value       = aws_iam_access_key.vrt_iam_keys.encrypted_secret
  #value = aws_iam_access_key.vrt_iam_keys.secret
  #sensitive = false
}

