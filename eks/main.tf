
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

/**
data "aws_vpc" "automation-vpc" {
  id = var.automation_vpc_id
}
*/


data "aws_iam_role" "eks-cluster-role" {
  name = "eks_cluster_role"
}

data "aws_iam_role" "eks-workers-role" {
  name = "eks_worker_node_group_role"
}

output "subnet_ids" {
    value = aws_subnet.jenkins_public_subnet_1[*].id
}

output "availability_zones" {
    value = var.aws_region_subnet_1
}