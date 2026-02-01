resource "aws_vpc" "myvpc" {
  cidr_block = var.Network.vpc_cidr
  tags = {
    Name = var.Network.vpc_name
  }
}

resource "aws_subnet" "mysubnets" {
  count             = local.my_con
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.Network.subnets[0].subnet_cidr[count.index]
  availability_zone = var.Network.subnets[0].subnet_az[count.index]
  tags = {
    Name = var.Network.subnets[0].subnet_names[count.index]
  }
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "My_IGW_revoke"
  }

}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "My_RT"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}

resource "aws_route_table_association" "RTA" {
  count          = local.my_con
  route_table_id = aws_route_table.RT.id
  subnet_id      = aws_subnet.mysubnets[count.index].id
}

resource "aws_security_group" "Mysecgp" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "My-Sec-Gp"
  }
  ingress {
    to_port     = 22
    protocol    = "tcp"
    from_port   = 22
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    to_port   = 0
    from_port = 0
    protocol  = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_key_pair" "keys" {
  public_key = file("~/.ssh/id_ed25519.pub")
  key_name   = "Myssh"
}

data "aws_ami" "ami_exist" {
  most_recent = true
  owners      = [ "099720109477" ]
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-minimal-20251204"]
  }
}

resource "aws_instance" "myec2" {
  ami                         = data.aws_ami.ami_exist.id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.Mysecgp.id]
  key_name                    = aws_key_pair.keys.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.mysubnets[0].id
  tags = {
    Name = "Myec2"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_ed25519")
    host        = aws_instance.myec2.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y"
    ]
  }
}