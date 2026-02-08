output "vpc" {
    value = data.aws_vpc.myexist_vpc.id
}

output "subnet" {
    value = data.aws_subnet.myexist_subnet.id
}

output "route_table" {
    value = data.aws_route_table.myexist_route_table.id
}

output "internet_gateway" {
    value = data.aws_internet_gateway.myexist_internet_gateway_way.id
}

output "sg" {
    value = aws_security_group.Mysg.id
}

output "ec2" {
    value = aws_instance.myec2
}

output "s3" {
    value = aws_s3_bucket.Mybucket.id
}

