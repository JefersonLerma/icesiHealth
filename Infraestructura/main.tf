
terraform {
  required_providers {
      aws = {
        source = "aws"
        version = "3.23.0" 
      }
  }
}

provider "aws" {
  acces_key  = var.credentials_acces_key
  secret_key = var.credentials_secret_key
  region = var.aws_region
}