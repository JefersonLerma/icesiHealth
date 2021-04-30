variable "aws_region" {
    type    = string
    default = "us-east-2"
}



variable "ami_id" {
    default = "ami-0f57b4cec24530068"
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
