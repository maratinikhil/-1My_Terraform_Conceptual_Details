variable "MyVpcSubnet" {
    description = "Creating Single vpc and Attaching to 5 subnets to the Vpc"
    type = object({
        vpc_name = string
        vpc_cidr = string
        subnets = list(object({
            subnet_cidr = list(string)
            subnet_az = list(string)
            subnet_name = list(string)
        }))
    })

    default = {
        vpc_name = "MyVpc-5"
        vpc_cidr = "172.16.0.0/16"
        subnets = [ {
            subnet_cidr = ["172.16.1.0/24","172.16.2.0/24","172.16.3.0/24","172.16.4.0/24","172.16.5.0/24"]
            subnet_az = ["ap-south-1a","ap-south-1b","ap-south-1a","ap-south-1b","ap-south-1c"]
            subnet_name = ["MyWebSub","MyAppSub","MyDBSub","MyAuthSub","MyAPISub"]
        } ]
    }
}