output "My_VPC" {
    value = aws_vpc.MyVpc.id
}

output "My_Subnet" {
    value = var.Network_info.subnets
}

output "My_Internet_Gateway" {
    value = aws_internet_gateway.MyIgW.id
}

output "My_Route_Table" {
    value = aws_route_table.Myrt.id
}


