provider "aws" {
  profile = var.aws_profile != "" ? var.aws_profile : null
  region  = var.aws_region
}