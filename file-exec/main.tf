resource "aws_vpc" "Myvpc" {
    cidr_block = var.network.vpc_cidr
    tags = {
        Name = var.network.vpc_name
    }
}

resource "aws_subnet" "Mysubnets" {
    count = local.my_con
    vpc_id = aws_vpc.Myvpc.id
    cidr_block = var.network.subnets[0].subnet_cidr[count.index]
    availability_zone = var.network.subnets[0].subnet_az[count.index]
    tags = {
        Name = var.network.subnets[0].subnet_name[count.index]
    }
}

resource "aws_internet_gateway" "Myig" {
    vpc_id = aws_vpc.Myvpc.id
    tags = {
        Name = "My_IG_unique"
    }
}

resource "aws_route_table" "Myrt" {
    vpc_id = aws_vpc.Myvpc.id
    tags = {
        Name = "My_rt_unique"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Myig.id
    }
}

resource "aws_route_table_association" "myrta" {
    count = local.my_con
    route_table_id = aws_route_table.Myrt.id
    subnet_id = aws_subnet.Mysubnets[count.index].id
}

resource "aws_security_group" "Mysg" {
    vpc_id = aws_vpc.Myvpc.id
    tags = {
        Name = "My-sec-gp"
    }
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        protocol = "tcp"
        to_port = 80
    }
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = "-1"
        
    }
}


resource "aws_key_pair" "Mykeys" {
    public_key = file("~/.ssh/id_ed25519.pub")
    key_name = "Mykeys_1"
}

data "aws_ami" "myami" {
    most_recent = true
    owners = [ "099720109477" ]
    filter {
      name = "name"
      values = [ "ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-minimal-20251204" ]
    }
}

resource "aws_instance" "myec2" {
    ami = data.aws_ami.myami.id
    instance_type = "t3.micro"
    associate_public_ip_address = true
    key_name = aws_key_pair.Mykeys.key_name
    subnet_id = aws_subnet.Mysubnets[0].id
    vpc_security_group_ids = [ aws_security_group.Mysg.id ]
    tags = {
        Name = "My_EC2_unique"
    }
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/id_ed25519")
        host = aws_instance.myec2.public_ip
    }
    provisioner "file" {
        source = "./mycmd.sh"
        destination = "/home/ubuntu/mycmd.sh"
    }

    provisioner "remote-exec" {
        inline = [ "sudo chmod +x /home/ubuntu/mycmd.sh",
                    "./mycmd.sh" 
        ]
    }
}
