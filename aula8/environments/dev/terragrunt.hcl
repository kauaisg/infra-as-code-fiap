include { path = find_in_parent_folders() }

terraform {
  source = "../../modules/root"
}

inputs = {
  env             = "dev"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.2.0/24", "10.0.4.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]

  # EC2
  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  key_name      = "iac-key"

  # RDS
  db_user = "admin"
  db_pass = "Admin1234!"

  # EKS opcional
  enable_eks      = false
  cluster_version = "1.30"
}
