# Aula 7 — Auditoria, Versionamento e Segurança em IaC (Projeto Prático)

Este pacote reúne **exemplos práticos** para consolidar os temas da Aula 7:
- Versionamento e rastreabilidade (usar Git/PRs como trilha de auditoria);
- Auditoria de execuções (integração com pipelines);
- Segurança aplicada a IaC (scanners, segredos, políticas).


 adiconar um conflito

 
## Conteúdo

- `insecure-terraform/`
  - Terraform propositalmente inseguro (S3 sem criptografia, SG aberto) para rodar **tfsec** e **Checkov**.
- `github-actions/.github/workflows/iac-security.yml`
  - Workflow de **GitHub Actions** que roda Checkov em Pull Requests.
- `opa-policy/`
  - Política **OPA/Rego** que reprova buckets S3 sem criptografia, com exemplo de input e instruções.

## Pré-requisitos

- Terraform >= 1.3 (apenas se quiser fazer `init/plan`; os scanners não exigem credenciais).
- **tfsec** e/ou **Checkov** instalados localmente (ou via Docker).
- **OPA** (Open Policy Agent) opcional para testar a política Rego.

## Como começar rapidamente

### Rodar scanners no código inseguro
```bash
cd insecure-terraform
tfsec .
# ou
checkov -d .
```

### Habilitar o scan em PRs no GitHub
- Copie a pasta `.github/workflows` (dentro de `github-actions/`) para a raiz do seu repositório.
- Abra um Pull Request; o job **IaC Security Scan** rodará automaticamente.

### Testar Policy as Code (OPA)
```bash
cd opa-policy
opa eval --format pretty --data policy.rego --input input-examples/s3_bucket.json "data.terraform.s3.deny"
```

## Observações de segurança
- **Não** aplique os recursos do diretório `insecure-terraform` em ambientes reais.
- Use gerenciadores de segredos (Vault, Secrets Manager) e **Policy as Code** na sua pipeline.
- Combine scanners + PRs + políticas para obter um ciclo de **DevSecOps** completo.
