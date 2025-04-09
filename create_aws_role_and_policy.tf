resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-eks-cluster-role"
  
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      },
      "Action" = [
        "sts:AssumeRole",
        "sts:TagSession"
        ]
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  count = length(var.clusterpol)
  role  = aws_iam_role.eks_cluster_role.name
  policy_arn = element(var.clusterpol, count.index)
}


resource "aws_iam_role" "eks_node_role" {
  name = "${var.cluster_name}-eks-node-role"
  
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      "Action" = [
        "sts:AssumeRole",
        ]
    }]
    Version = "2012-10-17"
  })
}
resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  count = length(var.noderole)
  role  = aws_iam_role.eks_node_role.name
  policy_arn = element(var.noderole, count.index)
}
