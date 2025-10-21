# OPA Policy — Aula 7

Exemplo de **Policy as Code** usando **Open Policy Agent (OPA)** para validar regras de S3.

## Arquivos
- `policy.rego` — política que nega buckets sem criptografia.
- `input-examples/s3_bucket.json` — exemplo de entrada para testar a política.

## Como testar localmente (com OPA instalado)

```bash
# Avaliar a política com o input de exemplo
opa eval --format pretty --data policy.rego --input input-examples/s3_bucket.json "data.terraform.s3.deny"
```

Se a política identificar o problema, você verá uma mensagem semelhante a:
```
[
  "Bucket iac-insecure-bucket-example não possui criptografia habilitada"
]
```
