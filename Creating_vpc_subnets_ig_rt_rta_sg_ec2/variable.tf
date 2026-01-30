variable "My_Network" {
  description = "My Network Details"
  type = object({
    vpc_cidr = string
    vpc_name = string
    subnets = list(object({
      subnet_cidr  = list(string)
      subnet_names = list(string)
      subnet_az    = list(string)
    }))
  })

  default = {
    vpc_cidr = "192.168.0.0/16"
    vpc_name = "Myvpc"
    subnets = [{
      subnet_cidr = [
        "192.168.2.0/24",
        "192.168.1.0/24",
        "192.168.3.0/24",
        "192.168.4.0/24"
      ]
      subnet_names = [
        "Sub1",
        "Sub2",
        "Sub3",
        "Sub4",
      ]
      subnet_az = [
        "ap-south-1a",
        "ap-south-1b",
        "ap-south-1c",
        "ap-south-1b",
      ]
    }]
  }
}