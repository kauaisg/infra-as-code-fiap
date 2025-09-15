# ==============================
# terraform.tfvars - Valores padrão
# ==============================

# Nome do ambiente
environment_name = "dev"

# AMI usada (substituir por uma válida na sua região AWS)
ami_id           = "ami-xxxxxxxxxxxxxxxxx"

# Tipo da instância
instance_type    = "t2.micro"

# Liberação de acesso SSH (por segurança, ajuste para seu IP)
ssh_access_cidr  = "0.0.0.0/0"

# IDs da VPC e Subnet existentes (substitua pelos seus)
vpc_id    = "vpc-xxxxxxxxxxxxxxxxx"
subnet_id = "subnet-xxxxxxxxxxxxxx"
