locals {
  cluster_name = "${var.resource_prefix}-${random_string.suffix.result}"
}
