# kubernetes_hcl/providers.tf
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
  }
}

provider "kubernetes" {
  # config_path    = "~/.kube/config"
  # config_context = "seu-contexto"
}
