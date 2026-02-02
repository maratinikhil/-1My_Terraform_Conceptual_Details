output "vpc" {
    value = aws_vpc.Myvpc.id
}

output "subnets" {
    value = aws_subnet.Mysubnets[0].id
}

output "Route_Table" {
    value = aws_route_table_association.myrta
}

output "Route_Table_Assocaition" {
    value = aws_route_table_association.myrta
}

output "Security_Group" {
    value = aws_security_group.Mysg
}

output "Key_Pair" {
    value = aws_key_pair.Mykeys.key_name
}

output "MyEC2" {
    value = aws_instance.myec2.id
}

output "url" {
    value = "http://${aws_instance.myec2.public_ip}:80"
}