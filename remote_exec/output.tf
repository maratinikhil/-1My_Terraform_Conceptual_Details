output "vpc" {
  value = aws_vpc.myvpc.id
}

output "subnets" {
  value = aws_subnet.mysubnets
}

output "internet_gateway" {
  value = aws_internet_gateway.myigw.id
}

output "route_table" {
  value = aws_route_table.RT.id
}

output "route_table_association" {
  value = aws_route_table_association.RTA
}

output "security_group" {
  value = aws_security_group.Mysecgp.id
}

output "keys" {
  value = aws_key_pair.keys.key_name
}

output "ami" {
  value = data.aws_ami.ami_exist.id
}

output "EC2" {
  value = aws_instance.myec2.id
}

output "url" {
  value = "http://${aws_instance.myec2.public_ip}:80"
}