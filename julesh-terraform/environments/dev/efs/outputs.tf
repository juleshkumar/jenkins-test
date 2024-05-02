output "efs_security_group_id" {
  description = "The ID of the AWS security group created for EFS mount targets"
  value       = module.efs.efs_security_group_id
}

output "efs_file_system_id" {
  description = "The ID of the AWS EFS file system"
  value       = module.efs.efs_file_system_id
}

output "efs_mount_target_ids" {
  description = "The IDs of the AWS EFS mount targets"
  value       = module.efs.efs_mount_target_ids
}

output "efs_mount_target_dns_names" {
  description = "The DNS names of the AWS EFS mount targets"
  value       = module.efs.efs_mount_target_dns_names
}
