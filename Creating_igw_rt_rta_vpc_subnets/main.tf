resource "aws_vpc" "MyVpc" {
    cidr_block = var.Network_info.vpc_cidr
    tags = {
        Name = var.Network_info.vpc_name
    }
}

resource "aws_subnet" "MySubnet" {
    count = local.Mylocal
    vpc_id = aws_vpc.MyVpc.id
    cidr_block = var.Network_info.subnets[0].subnet_cidr[count.index]
    availability_zone = var.Network_info.subnets[0].subnet_az[count.index]
    tags = {
        Name = var.Network_info.subnets[0].subnet_names[count.index]
    }
}

resource "aws_route_table" "Myrt" {
    vpc_id = aws_vpc.MyVpc.id
    tags = {
        Name = "MyRoute-2"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.MyIgW.id
    }

}

resource "aws_route_table_association" "MyRta" {
    count = local.Mylocal
    route_table_id = aws_route_table.Myrt.id
    subnet_id = aws_subnet.MySubnet[count.index].id
}

resource "aws_internet_gateway" "MyIgW" {
    vpc_id = aws_vpc.MyVpc.id
    tags = {
        Name = "MyIgw-1"
    }
}