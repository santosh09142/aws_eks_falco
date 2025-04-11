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
  host                   = module.eks.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  load_config_file       = false
}
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    load_config_file       = false
  }
}