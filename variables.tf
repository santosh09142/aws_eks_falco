variable "clusterpol" {
  description = "The cluster policy to be applied to the cluster."
  type        = list(string)
    default     = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
        "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy",
        "arn:aws:iam::aws:policy/AmazonEKSComputePolicy",
        "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy",
        "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
    ]
}

variable "noderole" {
    description = "This is EKS node role and policy"
    type        = list(string)
    default     = [
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy",
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "eks-cluster-1"
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group."
  type        = string
  default     = "/eks/falco"

}

variable "retention_in_days" {
  description = "The number of days to retain log events in the specified log group."
  type        = number
  default     = 7
}

variable "region" {
  description = "The AWS region to deploy the EKS cluster."
  type        = string
  default     = "us-east-1"
}