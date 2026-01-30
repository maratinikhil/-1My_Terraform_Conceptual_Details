My_Network_Details = {
  vpc_names = "My_vpc_prod"
  vpc_cidr  = "10.0.0.0/16"
  subnets = [{
    subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
    subnet_names = ["Prod_Sub_1", "Prod_Sub_2", "Prod_Sub_3", "Prod_Sub_4"]
    subnet_az    = ["ap-south-1a", "ap-south-1a", "ap-south-1b", "ap-south-1c"]
  }]
}