module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.0.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets

  tags = {
    Name = local.cluster_name
  }

  vpc_id = module.vpc.vpc_id

  node_groups = {
    study-k8s = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 2

      instance_types = ["t3.small"]

      k8s_labels = {
        Name = local.cluster_name
      }

      additional_tags = {
        Name = local.cluster_name
      }
    }
  }

  write_kubeconfig = false
  enable_irsa      = true
}
