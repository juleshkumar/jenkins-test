terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = ""
  }
}

provider "kubernetes" {
#  version = "~> 2.0"

  // Kubernetes cluster configuration
  host                   = module.eks.eks_cluster_endpoint
}