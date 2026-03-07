resource "aws_vpc" "vpc" {
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "My_VPC_1"
  }
  lifecycle {
    prevent_destroy = true
  }
}