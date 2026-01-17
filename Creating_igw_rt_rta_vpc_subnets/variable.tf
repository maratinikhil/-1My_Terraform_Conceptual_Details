variable "Network_info" {
    description = "Creating VPC, Subnets, IGW, Route Table, Route Table Association"
    type = object({
        vpc_cidr = string
        vpc_name = string
        subnets = list(object({
            subnet_cidr = list(string)
            subnet_az = list(string)
            subnet_names = list(string)
      }))
    })

    default = {
        vpc_cidr = "192.168.0.0/16"
        vpc_name = "MyVpc-5"
        subnets = [ {
            subnet_cidr = ["192.168.1.0/24","192.168.2.0/24","192.168.3.0/24","192.168.4.0/24","192.168.5.0/24"]
            subnet_az = ["ap-south-1a","ap-south-1b","ap-south-1a","ap-south-1b","ap-south-1c"]
            subnet_names = ["AppSub-1","AppSub-2","AppSub-3","AppSub-4","AppSub-5"]
        } ]
    }
}