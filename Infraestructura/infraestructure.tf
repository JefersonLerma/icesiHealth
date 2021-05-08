##########################################
## Resource to create a EC2 ##
##########################################
resource "aws_vpc" "vpc_jenkins" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"    
    tags = {
        Name = "vpc_jenkins"
    }
}

resource "aws_subnet" "jenkins_public_subnet_1" {
    vpc_id = "${aws_vpc.vpc_jenkins.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" 
    availability_zone = var.aws_region_subnet_1
    tags = {
        Name = "jenkins_public_subnet_1"
    }
}

resource "aws_security_group" "sg_infraestructure" {
    vpc_id = "${aws_vpc.vpc_jenkins.id}"
    name = "sg_infraestructure"
    description = var.sg_infraestructure_description

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Outbound rule"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        responsible = "sg_infraestructure"
    }
}

resource "aws_instance" "VM_Jenkins" {
    ami   = var.ami_id
    instance_type = var.type_instance
    subnet_id = "${aws_subnet.jenkins_public_subnet_1.id}"
    security_groups = ["${aws_security_group.sg_infraestructure.id}"]
    key_name = var.key_name
    count = var.count_instances
    tags = {
        Name = "jenkins_instance"
    } 
}   
