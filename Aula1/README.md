# Aula 1 - Fundamentos Terraform na AWS

Primeiro laboratório do curso: criação de Security Group e EC2 em VPC/Subnet existentes.

## Trilha AWS Academy
- Exporte credenciais temporárias do laboratório:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_SESSION_TOKEN`
  - `AWS_REGION=us-east-1`
- Mantenha `aws_profile = ""` no `terraform.tfvars`.

## Trilha Conta AWS Pessoal
- Configure um profile via AWS CLI/SSO.
- Defina no `terraform.tfvars`:
  - `aws_profile = "seu-profile"`
  - `aws_region = "us-east-1"`

## Pré-requisitos
- Terraform >= 1.4
- AWS CLI configurado

## Execução
```bash
aws sts get-caller-identity
terraform init
terraform validate
terraform plan
terraform apply
```

## Limpeza
```bash
terraform destroy
```

## Observações
- Ajuste `vpc_id` e `subnet_id` para recursos existentes na sua conta.
- Ajuste `ssh_access_cidr` para o CIDR permitido no seu ambiente.
