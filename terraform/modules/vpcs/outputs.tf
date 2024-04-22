output "vpc_id" { 
  description =  "vpc_id"
  value = aws_vpc.vpc.id 
} 

output "public_route_table_ids" { 
  description = "id of public route tables"
  value = aws_route_table.public_subnet_route_table
}
