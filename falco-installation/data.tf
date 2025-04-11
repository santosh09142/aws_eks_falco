data "terraform_remote_state" "eks" {
    backend = "local"
    config = {
        path = "${path.module}/../terraform.tfstate"
    }
    
}

data "aws_eks_cluster_auth" "eks_auth" {
    name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}