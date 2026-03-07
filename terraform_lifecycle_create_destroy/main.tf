resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "My-vpc-1"
  }
  lifecycle {
    create_before_destroy = true
  }
}