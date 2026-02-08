data "aws_vpc" "myexist_vpc" {
    filter {
        name = "tag:Name"
        values = [ "MyTerraVpc2" ]
    }
}

data "aws_subnet" "myexist_subnet" {
    filter {
        name = "tag:Name"
        values =[ "sub_1" ]
    }
}

data "aws_route_table" "myexist_route_table" {
    filter {
        name = "tag:Name"
        values = [ "MyRouteTable" ]
    }
} 

data "aws_internet_gateway" "myexist_internet_gateway_way" {
    filter {
        name = "tag:Name"
        values = [ "MyIGW" ]
    }
}

resource "aws_security_group" "Mysg" {
    vpc_id = data.aws_vpc.myexist_vpc.id
    tags = {
        Name = "Mysg_1"
    }
    ingress {
        from_port = 22
        protocol = "tcp"
        to_port = 80
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

data "aws_key_pair" "myexist_key_pair" {
    filter {
        name = "key-name"
        values = [ "ssh_key_pair" ]
    }
}


resource "aws_instance" "myec2" {
    vpc_security_group_ids = [ aws_security_group.Mysg.id ]
    instance_type = "t3.micro"
    subnet_id = data.aws_subnet.myexist_subnet.id
    associate_public_ip_address = true
    key_name = data.aws_key_pair.myexist_key_pair.key_name
    ami =  "ami-019715e0d74f695be"
    tags = {
        Name = "Myec2"
    }
}

resource "aws_s3_bucket" "Mybucket" {
    bucket = "mybucket-storage-ec2-git-terraform-with-ubuntu"
    force_destroy = true
}