resource "helm_release" "falco" {
  # Uncomment the following line to use the KOPS cluster provider
  # provider = helm.kops_cluster
  name             = "falco"
  repository       = "https://falcosecurity.github.io/charts"
  chart            = "falco"
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

  depends_on = [
    aws_eks_cluster.eks_cluster,
    terraform_data.kubectl_config,
  ]

}

resource "helm_release" "falco_custom_rules" {
  # Uncomment the following line to use the KOPS cluster provider
  # provider = helm.kops_cluster
  name             = "falco"
  repository       = "https://falcosecurity.github.io/charts"
  chart            = "falco"
#   version          = "4.14.1"
  namespace        = "falco"
  create_namespace = true
  reuse_values     = true
  wait             = false
  recreate_pods    = true
  timeout          = 600
  upgrade_install  = true
  values = [
    file("${path.module}/falco-config/falco-custom-rules.yaml")
  ]

  depends_on = [
    terraform_data.kubectl_config,
  ]
}