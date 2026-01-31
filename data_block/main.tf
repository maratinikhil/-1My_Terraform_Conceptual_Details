data "aws_vpc" "my_vpc_exist" {
  filter {
    name   = "tag:Name"
    values = ["myvpc_unique"]
  }
}

data "aws_subnet" "my_subnets_exists" {
  filter {
    name   = "tag:Name"
    values = ["my_unique_subnet"]
  }
  vpc_id = data.aws_vpc.my_vpc_exist.id
}

data "aws_internet_gateway" "my_internet_gateway_exist" {
  filter {
    name   = "tag:Name"
    values = ["Unique_IGW"]
  }
}

data "aws_route_table" "my_route_table_exist" {
  filter {
    name   = "tag:Name"
    values = ["unique_RT"]
  }
}

data "aws_security_group" "my_security_group_exist" {
  filter {
    name   = "group-name"
    values = ["Unique_SG"]
  }
  vpc_id = data.aws_vpc.my_vpc_exist.id
}

data "aws_ami" "my_ami_exist" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250627"]
  }
  owners = ["099720109477"]
}

resource "aws_key_pair" "my_keys" {
  public_key = file("~/.ssh/id_ed25519.pub")
  key_name   = "My_ssh_key_pair"
}

resource "aws_instance" "EC2" {
  ami                         = data.aws_ami.my_ami_exist.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [data.aws_security_group.my_security_group_exist.id]
  subnet_id                   = data.aws_subnet.my_subnets_exists.id
  key_name                    = aws_key_pair.my_keys.key_name
  tags = {
    Name = "EC2"
  }
}