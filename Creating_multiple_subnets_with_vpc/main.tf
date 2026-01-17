resource "aws_vpc" "Myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MYVPC-4"
    }
}

resource "aws_subnet" "Mysubnet1" {
    vpc_id = aws_vpc.Myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "MyWebSub1"
    }
}

resource "aws_subnet" "Mysubnet2" {
    vpc_id = aws_vpc.Myvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1c"
    tags = {
        Name = "MyWebSub2"
    }
}

resource "aws_subnet" "Mysubnet3" {
    vpc_id = aws_vpc.Myvpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name = "MyWebSub3"
    }
}