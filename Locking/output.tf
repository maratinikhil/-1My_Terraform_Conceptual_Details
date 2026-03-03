output "vpc" {
  value = aws_vpc.vpc.id
}

output "subnets" {
  value = var.My_Network.subnets
}

output "Route_Table" {
  value = aws_route_table.My_route.id
}

output "Internet_Gateway" {
  value = aws_internet_gateway.My_gateway.id
}

output "Security_Group" {
  value = aws_security_group.MySG.id
}

output "EC2" {
  value = aws_instance.My_EC2
}

# output "s3" {
#     value = aws_s3_bucket.MyS3Bucket
# }