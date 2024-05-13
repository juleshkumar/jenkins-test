output "efs_security_group_id" {
  description = "The ID of the AWS security group created for EFS mount targets"
  value       = aws_security_group.efs_mount_target_sg.id
}

output "efs_file_system_id" {
  description = "The ID of the AWS EFS file system"
  value       = aws_efs_file_system.my_efs.id
}

output "efs_mount_target_ids" {
  description = "The IDs of the AWS EFS mount targets"
  value       = aws_efs_mount_target.my_mount_target[*].id
}

output "efs_mount_target_dns_names" {
  description = "The DNS names of the AWS EFS mount targets"
  value       = aws_efs_mount_target.my_mount_target[1].dns_name
}
