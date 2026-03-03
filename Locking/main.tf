resource "aws_vpc" "vpc" {
  cidr_block = var.My_Network.vpc_id
  tags = {
    Name = var.My_Network.vpc_name
  }
}

resource "aws_subnet" "subnets" {
  count             = local.value
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.My_Network.subnets[0].subnet_cidr[count.index]
  availability_zone = var.My_Network.subnets[0].subnet_az[count.index]
  tags = {
    Name = var.My_Network.subnets[0].subnet_name[count.index]
  }
}

resource "aws_route_table" "My_route" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "My_Route_Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My_gateway.id
  }
}

resource "aws_route_table_association" "My_RA" {
  count          = local.value
  route_table_id = aws_route_table.My_route.id
  subnet_id      = aws_subnet.subnets[count.index].id
}

resource "aws_internet_gateway" "My_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "MyIG1"
  }
}

resource "aws_security_group" "MySG" {
  vpc_id      = aws_vpc.vpc.id
  name        = "Mysg"
  description = "Creating Security Group"
  tags = {
    Name = "My_Security_Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Inbound_Rule" {
  security_group_id = aws_security_group.MySG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "Outbound_Rule" {
  security_group_id = aws_security_group.MySG.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_key_pair" "Mykey" {
  key_name   = "Mykey"
  public_key = file("~/.ssh/id_ed25519.pub")
}

data "aws_ami" "Myami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-minimal-20260203"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "My_EC2" {
  vpc_security_group_ids      = [aws_security_group.MySG.id]
  ami                         = data.aws_ami.Myami.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.Mykey.key_name
  subnet_id                   = aws_subnet.subnets[0].id
  tags = {
    Name = "Godrej-Dev-App-Ubuntu-Machine-1"
  }
}

# resource "aws_s3_bucket" "MyS3Bucket" {
#     bucket = "godrej-app-ubuntu-db-unique"
#     force_destroy = true
# }