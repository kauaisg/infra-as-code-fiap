# Aula 4 – Automação com IaC e CI/CD (Terraform + GitHub Actions)

Este projeto demonstra como integrar **Terraform** a pipelines de **CI/CD com GitHub Actions**.

## Estrutura
- `main.tf` → infraestrutura simples (VPC, Subnet, SG, EC2)
- `variables.tf` → variáveis parametrizáveis
- `outputs.tf` → outputs para auditoria
- `dev.tfvars` → configuração do ambiente de desenvolvimento
- `prod.tfvars` → configuração do ambiente de produção
- `.github/workflows/terraform.yml` → pipeline CI/CD (plan, validate, apply)
- `.github/workflows/rollback.yml` → pipeline de rollback baseado em tags

## Como usar

### Trilhas de credenciais
- **AWS Academy**: exporte `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN` e `AWS_REGION`.
- **Conta AWS pessoal**: exporte `AWS_PROFILE` e `AWS_REGION`.

Valide credenciais:
```bash
aws sts get-caller-identity
```

1. Inicialize o Terraform:
```bash
terraform init
```

2. Planeje e aplique em **dev**:
```bash
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

3. Planeje e aplique em **prod**:
```bash
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

## GitHub Actions
- Push/PR nas branches `develop` e `main` → executa `fmt`, `validate`, `tflint` e `checkov`
- Push em `develop` e `main` também gera `plan` do ambiente correspondente
- Workflow `rollback.yml` roda `plan` de rollback a partir da tag informada
