locals {
  my_con = length(var.Network.subnets[0].subnet_cidr)
}