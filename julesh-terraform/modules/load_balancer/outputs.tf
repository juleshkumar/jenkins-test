output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.vrt_load_balancer.dns_name
}

output "lb_security_group" {
  value = aws_security_group.tf-sg.id
}