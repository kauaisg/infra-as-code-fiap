variable "env" { type = string }
variable "db_user" { type = string }
variable "db_pass" {
  type      = string
  sensitive = true
}
variable "private_subnet_ids" { type = list(string) }
variable "vpc_id" { type = string }
