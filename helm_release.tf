resource "helm_release" "albc" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.1.0"
  namespace  = "kube-system"

  values = [yamlencode(
    {
      clusterName = module.eks.cluster_id
      serviceAccount = {
        create = true
        name   = lower("aws-load-balancer-controller-${random_string.suffix.result}-service-account")
        annotations = {
          "eks.amazonaws.com/role-arn" = module.albc_irsa.this_iam_role_arn
        }
      }
    }
  )]
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  version    = "5.0.2"
  namespace  = "kube-system"

  values = [yamlencode(
    {
      extraArgs = {
        "kubelet-insecure-tls" : true
      }
      apiService = {
        create = true
      }
      rbac = {
        create = true
      }
      serviceAccount = {
        create = true
      }
    }
  )]
}
