# Provider
provider "aws" {
  region = "us-east-1"
}

# VPC
module "vpc" {
  source          = "../vpc"
  env             = var.env
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

# S3 genérico (ex: artefatos)
module "s3" {
  source = "../s3"
  env    = var.env
}

# EC2 (colocado na primeira subnet privada)
module "ec2" {
  source        = "../ec2"
  env           = var.env
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = module.vpc.private_subnet_ids[0]
}

# RDS (privado nas subnets privadas)
module "rds" {
  source             = "../rds"
  env                = var.env
  db_user            = var.db_user
  db_pass            = var.db_pass
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
}

# EKS (opcional)
module "eks" {
  source             = "../eks"
  env                = var.env
  cluster_version    = var.cluster_version
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id

  count = var.enable_eks ? 1 : 0
}
