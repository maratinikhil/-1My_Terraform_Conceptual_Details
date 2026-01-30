variable "My_Network_Details" {
  type = object({
    vpc_names = string
    vpc_cidr  = string
    subnets = list(object({
      subnet_cidr  = list(string)
      subnet_names = list(string)
      subnet_az    = list(string)
    }))
  })
}