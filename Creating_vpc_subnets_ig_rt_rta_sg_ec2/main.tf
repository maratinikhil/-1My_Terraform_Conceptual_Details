resource "aws_vpc" "myvpc" {
  cidr_block = var.My_Network.vpc_cidr
  tags = {
    Name = var.My_Network.vpc_name
  }
}

resource "aws_subnet" "Mysubnets" {
  vpc_id            = aws_vpc.myvpc.id
  count             = local.my_count_condition
  cidr_block        = var.My_Network.subnets[0].subnet_cidr[count.index]
  availability_zone = var.My_Network.subnets[0].subnet_az[count.index]
  tags = {
    Name = var.My_Network.subnets[0].subnet_names[count.index]
  }

}

resource "aws_internet_gateway" "Myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "My_IGW"
  }
}

resource "aws_route_table" "MyRT" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "My_Route_Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Myigw.id
  }
}

resource "aws_route_table_association" "MyRTA" {
  count          = local.my_count_condition
  route_table_id = aws_route_table.MyRT.id
  subnet_id      = aws_subnet.Mysubnets[count.index].id
}

resource "aws_security_group" "Mysec" {
  vpc_id      = aws_vpc.myvpc.id
  name        = "Mysec-gp"
  description = "Creating security group"
  tags = {
    Name = "Mysec-gp"
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = -1
    to_port   = 22
    protocol  = "tcp"
  }

}

resource "aws_key_pair" "Mykeys" {
  public_key = file("~/.ssh/id_ed25519.pub")
  key_name   = "ssh_keys"
}

resource "aws_instance" "EC2" {
    vpc_security_group_ids      = [aws_security_group.Mysec.id]
    key_name                    = aws_key_pair.Mykeys.key_name
    subnet_id                   = aws_subnet.Mysubnets[0].id
    instance_type               = "t3.micro"
    associate_public_ip_address = true
    ami                         = "ami-019715e0d74f695be"
    tags = {
        Name = "My_EC2_Instance"
    }
}

