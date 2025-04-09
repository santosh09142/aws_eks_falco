resource "helm_release" "falco" {
  # Uncomment the following line to use the KOPS cluster provider
  # provider = helm.kops_cluster
  name             = "falco"
  repository       = "http://falcosecurity.github.io/charts"
  chart            = "falcosecurity/falco"
#   version          = "4.14.1"
  namespace        = "falco"
  create_namespace = true
  wait             = false
  recreate_pods    = true
  timeout          = 600

  values = [
    templatefile("${path.module}/falco-config/falco-values.yaml", {
      aws_region    = var.region
    #   sqs_name      = module.sqs_sns_subscription.name
      irsa_role_arn = aws_iam_role.eks_cloudwatch_role.arn
    })
  ]
}