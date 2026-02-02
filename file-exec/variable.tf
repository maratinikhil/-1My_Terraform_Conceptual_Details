variable "network" {
    description = "My_vpc_subnets_details"
    type = object({
        vpc_cidr = string
        vpc_name = string
        subnets = list(object({
            subnet_cidr = list(string)
            subnet_name = list(string)
            subnet_az = list(string)
        }))
    })

    default = {
        vpc_cidr = "192.168.0.0/16"
        vpc_name = "My_vpc_unique"
        subnets = [ {
            subnet_cidr = [ "192.168.1.0/24","192.168.2.0/24","192.168.3.0/24","192.168.4.0/24" ]
            subnet_az = [ "ap-south-1a","ap-south-1b","ap-south-1a","ap-south-1c" ]
            subnet_name = [ "My_sub_unique_1","My_sub_unique_2","My_sub_unique_3","My_sub_unique_4" ]
        } ]
    }
}