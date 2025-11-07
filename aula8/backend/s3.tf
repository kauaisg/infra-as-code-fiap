# Bucket S3 para armazenar o state remoto (compartilhado)
resource "aws_s3_bucket" "state" {
  bucket = "iac-final-state"
  force_destroy = true
  versioning { enabled = true }
  server_side_encryption_configuration {
    rule { apply_server_side_encryption_by_default { sse_algorithm = "AES256" } }
  }
  tags = { Purpose = "Terraform Backend" }
}
