
terraform {
  required_providers {
      aws = {
        source = "aws"
        version = "3.23.0" 
      }
  }
}

provider "aws" {
  region = var.aws_region
}


data "aws_vpc" "automation-vpc" {
  id = var.automation_vpc_id
}
