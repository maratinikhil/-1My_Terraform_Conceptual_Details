resource "aws_vpc" "myvpc" {
    cidr_block = var.My_Network.vpccidr
    tags = {
        Name = var.My_Network.vpcname
    }
}

resource "aws_subnet" "mysubnet" {
    vpc_id = aws_vpc.myvpc.id
    count = length(var.My_Network.subnet_info[0].subnetcidr)
    cidr_block = var.My_Network.subnet_info[0].subnetcidr[count.index]
    availability_zone = var.My_Network.subnet_info[0].subnetaz[count.index]
    tags = {
        Name = var.My_Network.subnet_info[0].subnetname[count.index]
    }
}

resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "My_Ig"
    }
}

resource "aws_route_table" "Myrt" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "My_rt"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id
    }
}

resource "aws_route_table_association" "Myrta" {
    subnet_id = aws_subnet.mysubnet[0].id
    route_table_id = aws_route_table.Myrt.id
}

resource "aws_security_group" "Mysg" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "My_sg"
    }
    ingress {
        from_port = 22
        protocol = "tcp"
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "Mykeys" {
    public_key = file("~/.ssh/id_ed25519.pub")
    key_name = "My_keys"
}

data "aws_ami" "myami" {
    most_recent = true
    owners = [ "099720109477" ]
    filter {
        name = "name"
        values = [ "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-minimal-20251204" ]
    }
}

resource "aws_instance" "My_ec2" {
    ami = data.aws_ami.myami.id
    instance_type = "t3.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.mysubnet[0].id
    vpc_security_group_ids = [ aws_security_group.Mysg.id ]
    key_name = aws_key_pair.Mykeys.key_name
    tags = {
        Name = "MY_ec2"
    }
}

resource "null_resource" "myre" {
    triggers = {
        build = 1.1
    }
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/id_ed25519")
        host = aws_instance.My_ec2.public_ip
    }
    provisioner "remote-exec" {
        inline = [ 
            "sudo apt update",
            "sudo apt install nginx -y",
            "mkdir sample",
            "touch sample.py"
        ]
    }

}