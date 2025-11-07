resource "aws_s3_bucket" "storage" {
  bucket        = "${var.env}-app-storage"
  force_destroy = true

  versioning { enabled = true }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
    }
  }

  tags = { Name = "${var.env}-app-storage" }
}
