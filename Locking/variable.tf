variable "My_Network" {
  description = "My_vpc_subnets"
  type = object({
    vpc_id   = string
    vpc_name = string
    subnets = list(object({
      subnet_cidr = list(string)
      subnet_name = list(string)
      subnet_az   = list(string)
    }))
  })
  default = {
    vpc_id   = "192.168.0.0/16"
    vpc_name = "Myvpc1"
    subnets = [{
      subnet_cidr = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24"]
      subnet_az   = ["ap-south-1a", "ap-south-1b", "ap-south-1c", "ap-south-1a", "ap-south-1b"]
      subnet_name = ["My_App1", "My_Web1", "My_Db", "My_App2", "My_Web2"]
    }]
  }

}