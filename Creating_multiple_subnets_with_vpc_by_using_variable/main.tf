resource "aws_vpc" "MyVpc" {
    cidr_block = var.MyVpcSubnet.vpc_cidr
    tags = {
        Name = var.MyVpcSubnet.vpc_name
    }
}

resource "aws_subnet" "MySubnet" {
    count = length(var.MyVpcSubnet.subnets[0].subnet_cidr)
    vpc_id = aws_vpc.MyVpc.id
    cidr_block = var.MyVpcSubnet.subnets[0].subnet_cidr[count.index]
    availability_zone = var.MyVpcSubnet.subnets[0].subnet_az[count.index]
    tags = {
        Name = var.MyVpcSubnet.subnets[0].subnet_name[count.index]
    }
}