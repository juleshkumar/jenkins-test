data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/vpc"
    region     = "ap-south-1"
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket     = "terrafrom-test-to-delete-bucket"
    key        = "backend/kms"
    region     = "ap-south-1"
  }
}

resource "aws_cloudwatch_log_group" "group" {
  name              = "/aws/eks/${var.cluster-name}/cluster"
  retention_in_days = 7

}

resource "aws_iam_role" "eks-iam-role" {
  name = "eks-${var.cluster-name}-iam-role"

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


resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-iam-role.name
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name    = aws_eks_cluster.eks.name
}

data "aws_caller_identity" "current" {}

data "tls_certificate" "example" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.example.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.example.url
}


resource "aws_eks_cluster" "eks" {
  name                      = var.cluster-name
  role_arn                  = aws_iam_role.eks-iam-role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  version                   = var.k8s_version

  encryption_config {
    provider {
      key_arn = data.terraform_remote_state.kms.outputs.key_arn
    }
    resources = ["secrets"]
  }

  vpc_config {
    subnet_ids         = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
    endpoint_public_access = true
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role.eks-iam-role,
    aws_cloudwatch_log_group.group,
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,    #new
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController   #new
  ]

  tags = {
    "Name" = var.cluster-name
  }
}