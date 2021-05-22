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

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_jenkins.id 

  tags = {
    Name = "gw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc_jenkins.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id 
  }

 
  tags = {
    Name = "rt"
  }
}

resource "aws_route_table_association" "b" {
  subnet_id     = aws_subnet.jenkins_public_subnet_1.id 
  route_table_id = aws_route_table.rt.id 
}

resource "aws_route_table_association" "a" {
  subnet_id     = aws_subnet.jenkins_public_subnet_2.id 
  route_table_id = aws_route_table.rt.id 
}




resource "aws_subnet" "jenkins_public_subnet_1" {
    //vpc_id = var.automation_vpc_id
    vpc_id = "${aws_vpc.vpc_jenkins.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" 
    availability_zone = var.aws_region_subnet_1
    tags = {
        Name = "jenkins_public_subnet_1"
    }
}

resource "aws_subnet" "jenkins_public_subnet_2" {
    //vpc_id = var.automation_vpc_id
    vpc_id = "${aws_vpc.vpc_jenkins.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true" 
    availability_zone = var.aws_region_subnet_2
    tags = {
        Name = "jenkins_public_subnet_2"
    }
}

resource "aws_security_group" "sg_infraestructure" {
    //vpc_id = var.automation_vpc_id
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



//////////////////
resource "aws_eks_cluster" "cluster_eks" {

    name        = "cluster"
    role_arn    = var.eks_cluster_role_policy
    vpc_config  {
      subnet_ids = [aws_subnet.jenkins_public_subnet_1.id, aws_subnet.jenkins_public_subnet_2.id]
    }
}



resource "aws_eks_node_group" "workers_node" {
    cluster_name    = aws_eks_cluster.cluster_eks.name
    node_group_name = "eks_worker_node_group"
    node_role_arn   = var.eks_cluster_role_workers
    subnet_ids      = [aws_subnet.jenkins_public_subnet_1.id, aws_subnet.jenkins_public_subnet_2.id]

    scaling_config {
        desired_size    = 1
        max_size        = 5
        min_size        = 1
    }

    remote_access {
      ec2_ssh_key = var.key_name
    }
}




