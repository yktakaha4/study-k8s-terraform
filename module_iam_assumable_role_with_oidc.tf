module "albc_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "3.5.0"

  create_role      = true
  role_name        = "aws-load-balancer-controller-${random_string.suffix.result}-albc-role"
  role_policy_arns = [aws_iam_policy.albc.arn]
  provider_url     = module.eks.cluster_oidc_issuer_url
  oidc_fully_qualified_subjects = [
    lower("system:serviceaccount:kube-system:aws-load-balancer-controller-${random_string.suffix.result}-service-account")
  ]
}
