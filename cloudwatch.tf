resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
}

resource "aws_cloudwatch_log_stream" "cloudwatch_log_stream" {
  name           = var.cluster_name 
  log_group_name = aws_cloudwatch_log_group.cloudwatch_log_group.name
}

resource "aws_iam_role" "eks_cloudwatch_role" {
  name = "${var.cluster_name}-eks_cloudwatch_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" = "sts:AssumeRoleWithWebIdentity"
        "Effect" = "Allow"
        "Principal" = {
          "Federated" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer,"https://", "")}"
        },
        "Condition" = {
          "StringEquals" = {
            "${replace(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer,"https://", "")}:aud" = "sts.amazonaws.com"
            "${replace(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer,"https://", "")}:sub" = "system:serviceaccount:falco:falco-falcosidekick"
          }
        }
      }
    ]
  })
  depends_on = [
    aws_iam_openid_connect_provider.eks_oidc_provider
  ]
}

resource "aws_iam_role_policy" "eks_cloudwatch_policy"  {
  name   = "${var.cluster_name}-eks-cloudwatch-policy"
  role   = aws_iam_role.eks_cloudwatch_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}


# output "test" {
#   value       = replace(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer,"https://", "")
#   sensitive   = false
#   description = "description"
#   depends_on  = []
# }