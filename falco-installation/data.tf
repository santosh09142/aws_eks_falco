data "terraform_remote_state" "eks" {
    backend = "local"
    config = {
        path = "${path.module}/../eks/terraform.tfstate"
    }
    
}

resource "aws_eks_cluster_auth" "eks" {
    cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}