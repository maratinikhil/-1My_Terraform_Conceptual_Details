locals {
    my_con = length(var.network.subnets[0].subnet_cidr)
}