resource "aws_vpc" "myvpc" {
  cidr_block = var.My_Network_Details.vpc_cidr
  tags = {
    Name = var.My_Network_Details.vpc_names
  }
}

resource "aws_subnet" "mysubnets" {
  vpc_id            = aws_vpc.myvpc.id
  count             = length(var.My_Network_Details.subnets[0].subnet_cidr)
  cidr_block        = var.My_Network_Details.subnets[0].subnet_cidr[count.index]
  availability_zone = var.My_Network_Details.subnets[0].subnet_az[count.index]
  tags = {
    Name = var.My_Network_Details.subnets[0].subnet_names[count.index]
  }
}

resource "aws_route_table" "Myroutetable" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "My_Route_table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Myigw.id
  }
}

resource "aws_internet_gateway" "Myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "My_IG_1"
  }
}

resource "aws_route_table_association" "MyRTA" {
  route_table_id = aws_route_table.Myroutetable.id
  count          = length(var.My_Network_Details.subnets[0].subnet_cidr)
  subnet_id      = aws_subnet.mysubnets[count.index].id
}

