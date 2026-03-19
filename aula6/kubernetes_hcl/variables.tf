# kubernetes_hcl/variables.tf
variable "namespace" {
  description = "Namespace"
  type        = string
  default     = "demo"
}

variable "image" {
  description = "Imagem do container"
  type        = string
  default     = "nginx:1.25"
}

variable "replicas" {
  description = "Réplicas"
  type        = number
  default     = 2
}
variable "db_user" {
  description = "Usuário para o Secret de banco"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Senha para o Secret de banco"
  type        = string
  sensitive   = true
}
