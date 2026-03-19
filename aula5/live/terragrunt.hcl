# live/terragrunt.hcl
locals {
  aws_region   = "us-east-1"
  state_bucket = "REPLACE_ME_BUCKET"
  lock_table   = "REPLACE_ME_LOCK_TABLE"
}

generate "backend_guardrails" {
  path      = "backend_guardrails.tf"
  if_exists = "overwrite"
  contents  = <<EOF
locals {
  state_bucket = "${local.state_bucket}"
  lock_table   = "${local.lock_table}"
}

output "backend_remote_state_validation" {
  value = "ok"
  precondition {
    condition     = local.state_bucket != "REPLACE_ME_BUCKET" && local.lock_table != "REPLACE_ME_LOCK_TABLE"
    error_message = "Atualize state_bucket e lock_table no live/terragrunt.hcl antes de executar init/plan/apply."
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket         = local.state_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = local.lock_table
    encrypt        = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}
