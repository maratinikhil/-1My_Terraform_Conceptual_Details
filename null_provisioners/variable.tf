variable "My_Network" {
    description = "My_Network_Info"
    type = object({
        vpccidr = string
        vpcname = string
        subnet_info = list(object({
          subnetcidr = list(string)
          subnetaz = list(string)
          subnetname = list(string)
        }))
    })
    default = {
        vpccidr = "10.0.0.0/16"
        vpcname = "Myvpc_unique"
        subnet_info = [ {
            subnetcidr = [ "10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24" ]
            subnetaz = [ "ap-south-1a","ap-south-1a","ap-south-1b","ap-south-1c" ]
            subnetname = [ "sub1","sub2","sub3","sub4" ]
        } ]
    }
}