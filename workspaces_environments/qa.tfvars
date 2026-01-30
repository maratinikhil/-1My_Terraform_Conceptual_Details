My_Network_Details = {
  vpc_cidr  = "172.16.0.0/16"
  vpc_names = "My_vpc_QA"
  subnets = [{
    subnet_cidr  = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24", "172.16.4.0/24"]
    subnet_names = ["QA_Sub_1", "QA_Sub_2", "QA_Sub_3", "QA_Sub_4"]
    subnet_az    = ["ap-south-1a", "ap-south-1c", "ap-south-1b", "ap-south-1a"]
  }]
}