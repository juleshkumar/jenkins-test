output "id" {
  value       = aws_vpc.default.id
  description = "VPC ID"
}

output "public1_subnet_ids" {
  value       = aws_subnet.public1.id
  description = "List of public subnet IDs"
}

output "public2_subnet_ids" {
  value       = aws_subnet.public2.id
  description = "List of public subnet IDs"
}

output "private1_subnet_ids" {
  value       = aws_subnet.private1.id
  description = "List of private subnet IDs"
}

output "private2_subnet_ids" {
  value       = aws_subnet.private2.id
  description = "List of private subnet IDs"
}

output "cidr_block" {
  value       = var.cidr_block
  description = "The CIDR block associated with the VPC"
}

output "nat_gateway_ips" {
  value       = aws_eip.nat.*.public_ip
  description = "List of Elastic IPs associated with NAT gateways"
}
