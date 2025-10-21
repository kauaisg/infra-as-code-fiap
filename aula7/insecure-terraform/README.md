# Insecure Terraform — Aula 7

Este diretório contém **código propositalmente inseguro** para que as ferramentas
**tfsec** e **Checkov** identifiquem problemas. **Não** aplique em produção.

## Como usar (scanners)

> Dica: não é necessário AWS credenciada para rodar os scanners; eles analisam o código estático.

```bash
# dentro de insecure-terraform/
tfsec .

# ou
checkov -d .
```

Você deve ver alertas como:
- S3 bucket sem criptografia habilitada;
- Security Group expondo a porta 22 para 0.0.0.0/0;
- Outras recomendações de melhores práticas.
