# infra-as-code-fiap

Material prático de Infra as Code com Terraform/Terragrunt, organizado por aula.

## Trilha de execução (escolha uma)

### 1) AWS Academy (credenciais temporárias)
- Exporte as variáveis do laboratório:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_SESSION_TOKEN`
  - `AWS_REGION` (ex.: `us-east-1`)
- Valide credenciais:

```bash
aws sts get-caller-identity
```

### 2) Conta AWS pessoal (profile/SSO)
- Configure seu profile via AWS CLI/SSO.
- Exporte variáveis:
  - `AWS_PROFILE` (ex.: `default` ou `fiap`)
  - `AWS_REGION` (ex.: `us-east-1`)
- Valide credenciais:

```bash
aws sts get-caller-identity
```

## Pré-requisitos
- Terraform >= 1.4
- Terragrunt (aulas 5 e 8)
- AWS CLI
- kubectl e Helm (aula 6)
- tflint e checkov (qualidade/segurança)

## Ordem recomendada
- `Aula1`: fundamentos de provider, variáveis e EC2
- `aula2`: variáveis, outputs e backend remoto
- `aula3`: módulos, loops e condicionais
- `aula4`: CI/CD com GitHub Actions
- `aula5`: Terragrunt multi-ambiente com EKS
- `aula6`: Terraform para Kubernetes
- `aula7`: segurança e auditoria IaC
- `aula8`: projeto final modular com Terragrunt

## Fluxo padrão em cada aula

```bash
terraform init
terraform validate
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
terraform destroy -var-file="dev.tfvars"
```

Para aulas com Terragrunt (`aula5`, `aula8`), use `terragrunt init/plan/apply/destroy`.

## Guia rápido de segurança e custo
- Evite `0.0.0.0/0` para SSH fora de laboratório.
- Defina senhas por variável de ambiente (`TF_VAR_db_pass`) e nunca hardcode no código.
- Execute `destroy` ao final dos labs de EKS/RDS para evitar custos.
