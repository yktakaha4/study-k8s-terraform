module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.27"
  subnet_ids         = module.vpc.private_subnets

  tags = {
    Name = var.resource_prefix
  }

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups  = {
    study_k8s = {
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

  enable_irsa      = true
}
