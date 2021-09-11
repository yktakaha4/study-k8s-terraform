module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.47"

  name = local.cluster_name
  cidr = "${var.vpc_cidr_first_and_second_octets}.0.0/16"
  azs  = data.aws_availability_zones.available.names
  private_subnets = [
    "${var.vpc_cidr_first_and_second_octets}.1.0/24",
    "${var.vpc_cidr_first_and_second_octets}.2.0/24",
    "${var.vpc_cidr_first_and_second_octets}.3.0/24"
  ]
  public_subnets = [
    "${var.vpc_cidr_first_and_second_octets}.4.0/24",
    "${var.vpc_cidr_first_and_second_octets}.5.0/24",
    "${var.vpc_cidr_first_and_second_octets}.6.0/24"
  ]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
