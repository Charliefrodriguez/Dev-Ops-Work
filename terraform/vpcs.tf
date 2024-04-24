provider "aws" {  
  region = "us-east-2" 
}

module "test_vpc_1" { 
  source = "./modules/vpcs" 
  for_each  = var.vpc_configs  
  vpc_config = each.value 
} 

# simple vpc peer
resource "aws_vpc_peering_connection" "test_vpc_1_to_2" {
  peer_vpc_id   = module.test_vpc_1["vpc_config_2"].vpc_id
  vpc_id        = module.test_vpc_1["vpc_config_1"].vpc_id
  tags = { 
     Name = "test_vpc_1_to_2"  
   }
} 


resource "aws_route" "test_vpc0" {
  route_table_id            = "rtb-0f292de2032664d39"
  destination_cidr_block    = "10.1.4.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.test_vpc_1_to_2.id
}  

resource "aws_route" "test_vpc1" {
  route_table_id            = "rtb-0f0953589c0dbd56d"
  destination_cidr_block    = "10.0.3.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.test_vpc_1_to_2.id
} 


