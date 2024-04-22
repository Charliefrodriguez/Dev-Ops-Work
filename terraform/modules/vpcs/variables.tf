variable "vpc_config" { 

    type = object({ 
                 vpc_name = string
                 vpc_cidr = string
                 public_subnets =  list(string)
                 private_subnets = list(string)            
             })     

}
