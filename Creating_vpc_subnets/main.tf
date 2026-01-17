resource "aws_vpc" "MyNewvpc" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "MyVpc4"
    }
}

resource "aws_subnet" "Mysubnets" {
    vpc_id = aws_vpc.MyNewvpc.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "Mysub1"
    }
}

