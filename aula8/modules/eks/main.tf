module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "${var.env}-eks"
  cluster_version = var.cluster_version
  subnets         = var.private_subnet_ids
  vpc_id          = var.vpc_id

  manage_aws_auth_configmap = true

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      instance_types   = ["t3.medium"]
    }
  }

  tags = { Environment = var.env }
}
