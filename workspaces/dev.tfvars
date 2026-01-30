My_Network_Details = {
  vpc_names = "My_vpc_dev"
  vpc_cidr  = "192.168.0.0/16"
  subnets = [{
    subnet_cidr  = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
    subnet_names = ["Dev_Sub_1", "Dev_Sub_2", "Dev_Sub_3", "Dev_Sub_4"]
    subnet_az    = ["ap-south-1a", "ap-south-1b", "ap-south-1c", "ap-south-1c"]
  }]
}