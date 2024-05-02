# VRT Username:
output "vrt_username" {
  description = "IAM based VRT Username."
  value       = module.iam.vrt_username
}

# VRT user Acess Keys and Secret Keys
output "vrt_access_keys" {
  description = "VRT IAM Access Keys"
  value       = module.iam.vrt_access_keys
}

## VRT User Policy ARN
output "vrt_policy_arn" {
  description = "VRT User Policy ARN"
  value       = module.iam.vrt_policy_arn
}

output "vrt_secret_keys" {
  description = "VRT IAM Secret Keys"
  value       = module.iam.vrt_secret_keys
}

