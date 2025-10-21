# GitHub Actions — Scan de IaC com Checkov

Este exemplo adiciona um workflow de segurança que roda o **Checkov** em cada Pull Request
aberto contra a branch `main`. Se o Checkov encontrar problemas graves, o job falha e o merge é bloqueado.

## Como usar

1. Copie a pasta `.github/workflows` para a raiz do seu repositório no GitHub.
2. Abra um Pull Request modificando qualquer arquivo `.tf`.
3. Verifique a guia **Actions** do repositório para ver os resultados do Checkov.

> Dica: combine este workflow com um **branch protection rule** para exigir que o job passe
antes de permitir merge.
