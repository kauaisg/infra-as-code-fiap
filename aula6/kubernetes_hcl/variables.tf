# kubernetes_hcl/variables.tf
variable "namespace" { description = "Namespace" type = string default = "demo" }
variable "image" { description = "Imagem do container" type = string default = "nginx:1.25" }
variable "replicas" { description = "Réplicas" type = number default = 2 }
