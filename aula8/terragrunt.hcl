# terragrunt.hcl (raiz) - centraliza backend remoto para todos os ambientes
remote_state {
  backend = "s3"
  config = {
    bucket         = "iac-final-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
