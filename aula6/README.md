# Aula 6 - Kubernetes com Terraform

Este projeto demonstra como usar o Terraform para gerenciar recursos dentro de um cluster **Kubernetes** usando três abordagens diferentes:

1. **Kubernetes Provider (HCL)** → Criação de objetos diretamente com HCL (Deployment, Service, ConfigMap, Secret, RBAC).
2. **Kubectl Provider (YAML)** → Aplicação de manifestos YAML existentes.
3. **Helm Provider (Charts)** → Instalação do NGINX Ingress Controller a partir de um chart oficial.

---

## 📂 Estrutura de diretórios

- `kubernetes_hcl/` → Código em HCL para namespace, deployment Nginx, service, configmap, secret e RBAC.
- `kubectl_yaml/` → Uso do Kubectl Provider para aplicar YAMLs, incluindo Service e Ingress.
- `helm/` → Exemplo do Helm Provider para instalar o **NGINX Ingress Controller**, customizado via `values.yaml`.

---

## 🔧 Pré-requisitos

- Cluster Kubernetes ativo (ex: Minikube, Kind ou EKS).
- `kubectl` configurado e funcionando (`~/.kube/config` acessível).
- Terraform >= 1.3 instalado.
- Para Helm: acesso à internet para baixar charts.

## Trilhas AWS (quando usar EKS)

- **AWS Academy**: exporte `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN` e `AWS_REGION`.
- **Conta AWS pessoal**: exporte `AWS_PROFILE` e `AWS_REGION`.

Valide credenciais se estiver usando cluster EKS:
```bash
aws sts get-caller-identity
```

---

## ▶️ Passo a passo

### 1. Kubernetes Provider (HCL)
Entre no diretório `kubernetes_hcl/` e execute:

```bash
terraform init
terraform plan
terraform apply
```

Se necessário, forneça a senha do secret por variável:
```bash
export TF_VAR_db_password="troque-esta-senha"
```

Este exemplo cria:
- Namespace `demo`
- Deployment Nginx com 2 réplicas
- Service expondo o Nginx
- ConfigMap e Secret de exemplo
- RBAC aplicando **princípio do menor privilégio** (Role + RoleBinding)

### 2. Kubectl Provider (YAML)
Entre no diretório `kubectl_yaml/` e execute:

```bash
terraform init
terraform plan
terraform apply
```

Este exemplo aplica manifestos YAML para:
- Service do Nginx
- Ingress apontando para o Service (Ingress requer o NGINX Ingress Controller ativo)

### 3. Helm Provider (Ingress Controller)
Entre no diretório `helm/` e execute:

```bash
terraform init
terraform plan
terraform apply
```

O Terraform instalará o **NGINX Ingress Controller** no namespace `kube-system` usando o arquivo `values.yaml`, configurado para:
- 2 réplicas
- Service do tipo LoadBalancer
- Métricas habilitadas

---

## ⚠️ Observações importantes

- Os **Secrets** deste exemplo são apenas didáticos. Em ambientes reais, utilize ferramentas como **HashiCorp Vault** ou **AWS Secrets Manager**.
- No RBAC, o usuário `demo-user` deve ser substituído por uma ServiceAccount ou usuário existente no cluster.
- O **Ingress** só funcionará corretamente se houver um **Ingress Controller** rodando (instalado via Helm neste exemplo).

---

## 📘 Conceitos Reforçados

- **Kubernetes Provider** → ideal para padronizar recursos fixos em HCL.
- **Kubectl Provider** → ótimo para reaproveitar YAMLs existentes.
- **Helm Provider** → essencial para instalar aplicações complexas de forma simples.
- **RBAC** → aplicar **least privilege** para segurança e governança.
- **Ingress Controller** → ponto de entrada para expor serviços ao mundo externo.

---

## 🚀 Próximos Passos

- Experimente modificar o `values.yaml` e reinstalar o Ingress Controller.
- Crie novos ConfigMaps e conecte-os a Deployments.
- Explore a integração com **ArgoCD** para implantar aplicações com GitOps.

