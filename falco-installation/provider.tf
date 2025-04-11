# provider for AWS connect
terraform {
    required_providers {
          aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
          kubernetes = {
          source  = "hashicorp/kubernetes"
          version = "~> 2.36"
        }
          helm = {
          source  = "hashicorp/helm"
          version = "~> 2.17"
        }
    }
}

provider "aws" {
  region = var.region #"us-east-1"
}
# provider for AWS
provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  load_config_file       = false
  
}
provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks_cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    # load_config_file       = false
  }
}