output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "private_route_table_ids" {
  value = aws_route_table.private[*].id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  value = aws_default_route_table.default.id
}

output "security_groups" {
  value = aws_security_group.sg.id
}  



#available subnet mask vaues 

#17 (255.255.128.0)
#18 (255.255.192.0)
#19 (255.255.224.0)
#20 (255.255.240.0)
#21 (255.255.248.0)
#22 (255.255.252.0)
#23 (255.255.254.0)
#24 (255.255.255.0)
#25 (255.255.255.128)
#26 (255.255.255.192)
#27 (255.255.255.224)
#28 (255.255.255.240)
#29 (255.255.255.248)
#30 (255.255.255.252)
#31 (255.255.255.254)
#32 (255.255.255.255)
