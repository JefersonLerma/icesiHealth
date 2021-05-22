variable "aws_region" {
    type    = string
    default = "us-east-2"
}

variable "aws_region_subnet_1" {
    type    = string
    default = "us-east-2a"
}

variable "aws_region_subnet_2" {
    type    = string
    default = "us-east-2b"
}

/**
variable "automation_vpc_id" {
  default = "vpc-061a6528eea17003b"
}
*/

variable "ami_id" {
    default = "ami-00399ec92321828f5"
}

variable "count_instances"{
    default = 1
}

variable "key_name" {
    default = "estudiantes_automatizacion_2021_1"
}

variable "type_instance" {
    default = "t2.micro"
}

variable "sg_infraestructure_description" {
    default = "security group for instances of Jenkins on infraestructure"
}

variable "tag_responsible" {
    default = "estudiantes_automatizacion_2021_1"
}

/////////////////////////////
variable "eks_cluster_name" {
    type = string
    default = "cluster"
}  

variable "eks_cluster_role_policy" {
  type = string
  default = "arn:aws:iam::682086073548:role/eks_cluster_role"
}

variable "eks_cluster_role_workers" {
  type = string
  default = "arn:aws:iam::682086073548:role/eks_worker_node_group_role"
}