# policy.rego — Exemplo simples de Policy as Code (OPA/Rego) para S3
package terraform.s3

# Regra: negar buckets sem criptografia
deny[msg] {
  input.resource_type == "aws_s3_bucket"
  not input.encryption
  msg := sprintf("Bucket %s não possui criptografia habilitada", [input.name])
}
