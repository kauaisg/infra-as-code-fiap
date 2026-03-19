# iac-final-project – Aula 8 (Terraform + Terragrunt + AWS)

Projeto final do curso, com infraestrutura completa, modular e automatizada.
Região padrão: **us-east-1**.

## Componentes
- **modules/**: VPC, EC2, RDS, S3 e EKS (opcional)
- **modules/root/**: módulo agregador que compõe toda a infra
- **backend/**: S3 (state) + DynamoDB (lock)
- **environments/**: dev, staging, prod (Terragrunt)

## Trilhas de credenciais

### AWS Academy
- Exporte `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN` e `AWS_REGION`.

### Conta AWS pessoal
- Exporte `AWS_PROFILE` e `AWS_REGION` (ou profile SSO ativo).

Valide antes do bootstrap:
```bash
aws sts get-caller-identity
```

## Passo a passo
1. **Backend**
   ```bash
   cd backend
   terraform init
   terraform apply
   ```
2. **Execução com Terragrunt**
   ```bash
   export TF_VAR_db_pass="troque-por-uma-senha-forte"
   cd environments/dev
   terragrunt init
   terragrunt plan
   terragrunt apply
   ```
3. **EKS opcional**
   - Habilitado por padrão no `prod` via `enable_eks = true`.
   - Pode habilitar no `dev/staging` ajustando `inputs` em `terragrunt.hcl`.

## CI/CD (GitHub Actions + OIDC)
- Utilize os workflows na raiz do repositório para validação contínua de IaC.
- Para aplicar via CI em conta AWS real, configure OIDC e role dedicada com menor privilégio.

## Segurança
- Evite credenciais estáticas. Use OIDC.
- Ajuste CIDRs/portas conforme sua política interna.
- Em produção, use Secrets Manager para credenciais de DB.
