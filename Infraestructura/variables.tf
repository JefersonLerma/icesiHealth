variable "aws_region" {
    type    = string
    default = "us-east-2"
}

variable "credentials_acces_key" {
  default = "AKIAZ5T37QTGHF7OZWCZ"
}

variable "credentials_secret_key" {
    default = "BiIEhHEg5wajKAYU+okeXhvufNLOBRnz7SShw5FS"
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