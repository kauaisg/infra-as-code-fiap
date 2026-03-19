# kubectl_yaml/providers.tf
terraform {
  required_version = ">= 1.4.0"
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.0"
    }
  }
}

provider "kubectl" {
  # config_path    = "~/.kube/config"
  # config_context = "seu-contexto"
}
