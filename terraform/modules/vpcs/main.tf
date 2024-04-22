locals { 

  tags_public = tomap({ 
     for i,v in var.vpc_config.public_subnets : v => "${var.vpc_config.vpc_name}-public-subnet-${i}"
    })

  tags_private = tomap({ 
     for i,v in var.vpc_config.private_subnets : v =>  "${var.vpc_config.vpc_name}-private-subnet-${i}"	
    }) 
  
}



# create vpc
resource "aws_vpc" "vpc" { 
   cidr_block = var.vpc_config.vpc_cidr
   tags = { 
	Name = var.vpc_config.vpc_name
   } 
}

# create subnets
resource "aws_subnet" "public_subnets" { 
  for_each = toset(var.vpc_config.public_subnets)
  vpc_id = aws_vpc.vpc.id  
  cidr_block = each.key 
  tags = { 
     Name = local.tags_public[each.key] 
     vpc = aws_vpc.vpc.id 
  } 

}

resource "aws_internet_gateway" "public_subnet_gateway" { 
   count = length(var.vpc_config.public_subnets) > 0 ? 1 : 0 
   vpc_id = aws_vpc.vpc.id 
   tags = { 
	  Name = "igw_for_${aws_vpc.vpc.id}"
   }
} 

resource "aws_route_table_association" "public_subnet_route_table_assoc" {
  for_each  = toset(var.vpc_config.public_subnets)
  subnet_id      = aws_subnet.public_subnets[each.key].id 
  route_table_id = aws_route_table.public_subnet_route_table[each.key].id
   
  depends_on = [aws_subnet.public_subnets,aws_route_table.public_subnet_route_table]
}

resource "aws_route_table" "public_subnet_route_table" {
  for_each = toset(var.vpc_config.public_subnets)
  vpc_id = aws_vpc.vpc.id

  route { 
	   cidr_block = "0.0.0.0/0" 
           gateway_id = aws_internet_gateway.public_subnet_gateway[0].id
	} 
  
 depends_on = [aws_subnet.public_subnets]
  
 tags = {
    Name = "rb_for_${local.tags_public[each.key]}" 
    vpc = aws_vpc.vpc.id 
  }
}


# create subnets
resource "aws_subnet" "private_subnets" { 
  for_each = toset(var.vpc_config.private_subnets)
  vpc_id = aws_vpc.vpc.id  
  cidr_block = each.key
  tags = { 
   Name = local.tags_private[each.key] 
   vpc = aws_vpc.vpc.id 
  } 

}


output tag_public { 
   value = local.tags_public
} 


