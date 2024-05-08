data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/vpc"
    region     = "ap-south-1"
  }
}

resource "aws_lb" "vrt_load_balancer" {
  name                       = var.load_balancer_name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  enable_deletion_protection = false
  security_groups            = [aws_security_group.tf-sg.id]
  subnets                    = data.terraform_remote_state.vpc_state.outputs.public_subnet_ids

  tags = {
    Name = "LoadBalancer"
  }
}


resource "aws_lb_listener" "lis80" {
  load_balancer_arn = aws_lb.vrt_load_balancer.arn
  port              = var.lb-port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn

  }
}

resource "aws_lb_target_group" "tg" {
  name     = var.target-group-name
  port     = var.lb-port
  protocol = var.protocol
  vpc_id   = data.terraform_remote_state.vpc_state.outputs.vpc_id
}

resource "aws_security_group" "tf-sg" {
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id
  name        = var.lb_security_group
  description = var.lb_security_group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sg_rule_ig" {
  type              = "egress"
  from_port         = var.from_ports
  to_port           = var.to_ports
  protocol          = "tcp"
  cidr_blocks       = [var.security-group-cidr]
  security_group_id = aws_security_group.tf-sg.id
  description       = "security group rule for tf-sg"
}

# uncomment this when you have a existing autoscalng group 

#resource "aws_autoscaling_attachment" "test" {
#  autoscaling_group_name = var.autoscaling-group-name
#  lb_target_group_arn   = aws_lb_target_group.tg.arn
#}
