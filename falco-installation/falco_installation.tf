locals {
  falco_base_values = file("${path.module}/falco-config/falco-values.yaml")
}

locals {
  falco_custom_rules = file("${path.module}/falco-config/falco-custom-rules.yaml")
}


resource "helm_release" "falco" {
  # Uncomment the following line to use the KOPS cluster provider
  # provider = helm.kops_cluster
  name             = "falco"
  repository       = "https://falcosecurity.github.io/charts"
  chart            = "falco"
  namespace        = "falco"
  create_namespace = true
  wait             = false
  recreate_pods    = true
  timeout          = 600

  values = [
    templatefile("${path.module}/falco-config/falco-values.yaml", {
      # aws_region    = data.terraform_remote_state.eks.outputs.eks_region
    #   sqs_name      = module.sqs_sns_subscription.name
      # irsa_role_arn = aws_iam_role.eks_cloudwatch_role.arn
      irsa_role_arn = data.terraform_remote_state.eks.outputs.eks_cloudwatch_role
    }),
    # local.falco_custom_rules
  ]

  reuse_values = true

  # set {
  #   name  = "falcosidekick.enabled"
  #   value = "false"
  # }
}

resource "kubernetes_config_map" "falco_custom_rules" {
  # Uncomment the following line to use the KOPS cluster provider
  # provider = kubernetes.kops_cluster
  metadata {
    name      = "falco-custom-rules"
    namespace = "falco"
  }

  data = {
    "falco-custom-rules.yaml" = local.falco_custom_rules
  }
  depends_on = [
    helm_release.falco
  ] 
}

# resource "helm_release" "falco_custom_rules" {
#   # Uncomment the following line to use the KOPS cluster provider
#   # provider = helm.kops_cluster
#   name             = "falco"
#   repository       = "https://falcosecurity.github.io/charts"
#   chart            = "falco"
# #   version          = "4.14.1"
#   namespace        = "falco"
#   create_namespace = false
#   reuse_values     = true
#   wait             = false
#   recreate_pods    = true
#   timeout          = 600
#   upgrade_install  = true
#   values = [
#     file("${path.module}/falco-config/falco-custom-rules.yaml")
#   ]

# }