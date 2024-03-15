output "vpcs" {
  description = "VPC Outputs"
  value       = { for vpc in aws_vpc.main : vpc.tags.Name => { "cidr_block" : vpc.cidr_block, "id" : vpc.id } }
}
