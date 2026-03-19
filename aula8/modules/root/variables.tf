variable "env" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}

variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}

variable "db_user" {
  type = string
}
variable "db_pass" {
  type      = string
  sensitive = true
  validation {
    condition     = length(trimspace(var.db_pass)) >= 12
    error_message = "db_pass deve ter ao menos 12 caracteres e ser informado via TF_VAR_db_pass."
  }
}

variable "enable_eks" {
  type    = bool
  default = false
}
variable "cluster_version" {
  type    = string
  default = "1.30"
}
