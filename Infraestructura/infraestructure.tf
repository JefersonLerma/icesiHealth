##########################################
## Resource to create a EC2 ##
##########################################
resource "aws_instance" "VM_Jenkins" {
    ami   = var.ami_id
    count = var.count_instances
    key_name = var.key_name
    instance_type = var.type_instance
    security_groups = ["sg-infraestructure"]
    tags = {
        Name = "jenkins_instance"
    } 
}


resource "aws_security_group" "sg-infraestructure" {
    name = "sg-infraestructure"
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

    tags {
        responsible = "sg-infraestructure"
    }
}
