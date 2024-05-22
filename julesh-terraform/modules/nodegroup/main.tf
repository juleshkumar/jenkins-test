data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/vpc"
    region     = "ap-south-1"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/eks"
    region     = "ap-south-1"
  }
}

resource "aws_iam_role" "node" {
  name = "eks-${var.cluster-name}-node-0"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_policy" "node_ca" {
  #  count      = cluster-autoscaler ? 1 : 0
  name        = "eks-${var.cluster-name}-ca"
  path        = "/"
  description = "EKS Cluster Autoscalar policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {
  count      = var.cloudwatch_logs ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_ca" {
#  count      = cluster-autoscaler ? 1 : 0
  policy_arn = aws_iam_policy.node_ca.arn
  role       = aws_iam_role.node.name
}

resource "tls_private_key" "ssh_server_eks" {

  algorithm = "RSA"
  rsa_bits  = 2048
}


resource "aws_key_pair" "eks" {
  key_name   = var.eks_key_name
  public_key = var.public_key_file != null ? file(var.public_key_file) : tls_private_key.ssh_server_eks.public_key_openssh
}

#efs-mount sg

resource "aws_security_group" "efs_mount_target_sg" {
  name_prefix = "efs-mount-target-sg-"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  // Define ingress and egress rules as needed
  ingress {
    description = "Allow NFS traffic from EFS mount targets"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere (adjust as needed)
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"] # Allow traffic from anywhere (adjust as needed)
  }

  // Add ingress rule for HTTPS (port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere (adjust as needed)
  }

  # Define egress rules to allow outbound traffic from the worker nodes
  # Example: Allow all outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Add more ingress or egress rules as needed
}




resource "aws_eks_node_group" "spot" {
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_id
  node_group_name = "${var.cluster-name}-spot"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
  instance_types  = [var.instance-type-spot]
  capacity_type   = var.instance_capacity_types_spot
  disk_size       = var.inst_disk_size


  labels = {
    vrt-cug-kafka     = "true",
    vrt-elk           = "true",
    vrt-cug-consul    = "true",
    vrt-cug-logstash  = "true",
    vrt-cug-nginx     = "true",
  }

  taint {
    key    = "key"
    value  = "persistTool"
    effect = "NO_SCHEDULE"
  }

  scaling_config {
    desired_size = var.num-workers-spot
    max_size     = var.max-workers-spot
    min_size     = var.num-workers-spot
  }

  remote_access {
    ec2_ssh_key = aws_key_pair.eks.key_name
    source_security_group_ids = [aws_security_group.efs_mount_target_sg.id]
  }

  tags = {
    "Name" = "${var.cluster-name}-spot"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "on_demand" {
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_id
  node_group_name = "${var.cluster-name}-demand"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
  instance_types  = [var.instance-type-on-demand]
  capacity_type   = var.instance_capacity_types_demand
  disk_size       = var.inst_disk_size
  


  labels = {
    vrt-consul     = "true",
    vrt-monitoring = "true",
  }


  scaling_config {
    desired_size = var.num-workers-demand
    max_size     = var.max-workers-demand
    min_size     = var.num-workers-demand
  }

    remote_access {
      ec2_ssh_key = aws_key_pair.eks.key_name
      source_security_group_ids = [aws_security_group.efs_mount_target_sg.id]
    }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "${var.cluster-name}-demand"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}



