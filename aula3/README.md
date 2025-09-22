# Aula 3 – Projeto Prático (Módulos, Loops e Condicionais)

Este projeto demonstra o uso de:
- Módulos locais e públicos
- Loops (`count` e `for_each`)
- Condicionais (`ternary` e recurso opcional)
- Dynamic blocks
- For expressions
- Ambientes dev/prod com `.tfvars`

## Estrutura
- `main.tf` → Projeto principal com exemplos de todos os conceitos
- `modules/network/` → Módulo local para criação de VPC e subnets
- `dev.tfvars` → Configuração para ambiente de desenvolvimento
- `prod.tfvars` → Configuração para ambiente de produção

## Como usar

1. Inicialize o projeto:
```bash
terraform init
```

2. Planeje para o ambiente de desenvolvimento:
```bash
terraform plan -var-file="dev.tfvars"
```

3. Aplique em desenvolvimento:
```bash
terraform apply -var-file="dev.tfvars"
```

4. Visualize os outputs:
```bash
terraform output
```

5. Destrua o ambiente dev:
```bash
terraform destroy -var-file="dev.tfvars"
```

6. Repita os passos para `prod.tfvars` se desejar simular produção.
