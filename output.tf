
output "eks_cluster_role" {
  value       = aws_iam_role.eks_cluster_role.name
  sensitive   = false
  description = "description"
  depends_on  = []
}

output "eks_node_role" {
  value       = aws_iam_role.eks_node_role.name
}

output "eks_cluster_role_arn" {
  value       = aws_iam_role.eks_cluster_role.arn
  sensitive   = false
  description = "description"
  depends_on  = []
}

output "eks_cluster_info" {
  value       = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
  sensitive   = false
  description = "description"
  depends_on  = []
}

output "eks_cloudwatch_role" {
  value       = aws_iam_role.eks_cloudwatch_role.arn
  sensitive   = false
  description = "description"
  depends_on  = []
}