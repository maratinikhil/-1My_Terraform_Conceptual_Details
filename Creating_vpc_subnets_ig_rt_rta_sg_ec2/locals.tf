locals {
    my_count_condition = length(var.My_Network.subnets[0].subnet_cidr)
}