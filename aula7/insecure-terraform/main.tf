# Aula 7 – Exemplo propositalmente INSEGURO para scanners (tfsec/Checkov)
# Objetivo: fornecer código com más práticas para que as ferramentas apontem alertas.
# NÃO aplique este código em produção.

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# Provider AWS: somente necessário se você for rodar 'plan/apply'.
# Para rodar os scanners, não é necessário credenciais.
provider "aws" {
  region = "us-east-1"
}

# -------------------------
# 1) S3 bucket SEM criptografia (má prática)
# -------------------------
resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "iac-insecure-bucket-example-CHANGE-ME" # altere para um nome único se for aplicar de verdade
  # Nenhuma configuração de encryption aqui -> scanners devem alertar
}

# -------------------------
# 2) Security Group abrindo SSH (22/tcp) para o mundo (0.0.0.0/0) – má prática
# -------------------------
variable "vpc_id" {
  description = "VPC utilizada para associar o Security Group (placeholder)"
  type        = string
  default     = "vpc-123456" # placeholder; substitua por um ID real apenas se for aplicar (não recomendado)
}

resource "aws_security_group" "insecure_sg" {
  name        = "insecure-sg"
  description = "SG com regras inseguras (exemplo didático)"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH aberto para o mundo (inseguro)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Saída irrestrita (comum, mas scanners podem sugerir restrição)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "aula7-iac-security"
    Risk    = "high"
  }
}

# -------------------------
# 3) KMS key com rota de exemplo faltando políticas restritivas (apenas ilustrativo)
# -------------------------
# resource "aws_kms_key" "weak_kms" {
#   description             = "Exemplo de KMS sem política reforçada (comentado para evitar cobrança inadvertida)"
#   deletion_window_in_days = 7
# }
