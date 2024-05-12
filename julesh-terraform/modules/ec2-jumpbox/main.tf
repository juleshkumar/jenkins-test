data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/vpc"
    region     = "ap-south-1"
  }
}


#IAM USER 

resource "aws_iam_role" "js-iam-role" {
  name = "eks-${var.js_user}-iam-role"

  path = "/"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "js_user_ec2_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "js_user_efs_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
}

resource "aws_iam_role_policy_attachment" "js_user_eks_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "js_user_elasticache_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess"
}

resource "aws_iam_role_policy_attachment" "js_user_rds_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "js_user_s3_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "js_user_vpc_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_role_policy_attachment" "js_user_subaccounts_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess" 
}




##if you don't have apublic key use the below commands to generate key 
#  - ssh-keygen -t rsa -b 2048 -C "your_email@example.com"
#  - replace your email id 

resource "aws_eip" "master" {
  vpc = true
}

resource "aws_eip_association" "master" {
  allocation_id = aws_eip.master.id
  instance_id   = aws_instance.master.id
}



#resource "aws_security_group" "securitygroup-jump" {
#  name        = "jumpbox-${var.ec2_key_name}-alpha"
#  description = "Default SG to alllow traffic from the VPC mysg"
#  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id
#  ingress {
#    from_port = "22"
#    to_port   = "22"
#    protocol  = "tcp"
#    #cidr_blocks = ["3.108.14.224/32"]
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  egress {
#    from_port   = "0"
#    to_port     = "0"
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#}


resource "aws_security_group" "securitygroup-jump" {
  name        = "jumpbox-${var.ec2_key_name}-alpha"
  description = "Default SG to allow traffic from the VPC mysg"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id
  
  # Ingress rules
  ingress {
    from_port   = 22  # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  # Allow EKS control plane access 
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow access to RDS 
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow access to ElastiCache Redis 
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"  # All protocols
    cidr_blocks     = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}



resource "aws_instance" "master" {
  ami             = var.ami
  instance_type   = var.ec2_instance_type
  key_name        = var.ec2_key_name
  subnet_id       = data.terraform_remote_state.vpc_state.outputs.public_subnet_ids[0]
  security_groups = ["${aws_security_group.securitygroup-jump.id}"]
  iam_instance_profile = aws_iam_instance_profile.js_instance_profile.name
  tags = {
    Name = var.ec2_key_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "js_instance_profile" {
  name = "${var.js_user}-instance-profile"
  role = aws_iam_role.js-iam-role.name
}


