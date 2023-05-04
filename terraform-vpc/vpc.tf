// VPC

resource "aws_vpc" "vpc_prd" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc prd"
  }
}

resource "aws_subnet" "public_prd" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(var.vpc_cidr, 5, count.index + 8)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc_prd.id
  tags = {
    "Name" = "public-subnet-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

// Internet Gateway

resource "aws_internet_gateway" "igw_prd" {
  vpc_id = aws_vpc.vpc_prd.id

  tags = {
    Name = "Internet Gateway prd"
  }
}

// Public Route table

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc_prd.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_prd.id
  }

  tags = {
    Name = "public-route"
  }
}

//Public Route table association 

resource "aws_route_table_association" "public" {
  count          = 2 //length(data.aws_availability_zones.available.names)
  subnet_id      = element(aws_subnet.public_prd.*.id, count.index)
  route_table_id = aws_route_table.public_route.id
}

resource "aws_security_group" "sg_will" {
  vpc_id = aws_vpc.vpc_prd.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // This means, all ip address are allowed to ssh ! 
    // Do not do it in the production. 
    // Put your office or home address in it!
    cidr_blocks = [var.cidr_blocks]
  }
  //If you do not add this rule, you can not reach the NGIX  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_will"
  }
}
// Subnets

//resource "aws_subnet" "private_lab" {
//  count             = 2
//  availability_zone = data.aws_availability_zones.available.names[count.index]
//  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index)
//  vpc_id            = aws_vpc.vpc_prd.id
//  tags = {
//    "Name" = "Private-subnet-${element(data.aws_availability_zones.available.names, count.index)}"
//  }
//}
//
// NAT Gateway

//resource "aws_nat_gateway" "nat_prd" {
//  count         = 2 //length(data.aws_availability_zones.available.names)
//  allocation_id = element(aws_eip.nat.*.id, count.index)
//  subnet_id     = element(aws_subnet.public_prd.*.id, count.index)
//
//  tags = {
//    Name = "NAT Gateway prd ${element(data.aws_availability_zones.available.names, count.index)}"
//  }
//}
//
//// Nat Gateway Elastic IP
//
//resource "aws_eip" "nat" {
//  count = 2 //length(data.aws_availability_zones.available.names)
//  vpc   = true
//}
//Private Route table

//resource "aws_route_table" "private_route" {
//  count  = 2 //length(data.aws_availability_zones.available.names)
//  vpc_id = aws_vpc.vpc_prd.id
//  tags = {
//    Name = "private-route"
//  }
//}
//
//resource "aws_route" "private_route" {
//  count                  = 2 //length(data.aws_availability_zones.available.names)
//  route_table_id         = element(aws_route_table.private_route.*.id, count.index)
//  destination_cidr_block = "0.0.0.0/0"
//  nat_gateway_id         = element(aws_nat_gateway.nat_prd.*.id, count.index)
//}
//
////Private Route table association
//
//resource "aws_route_table_association" "private" {
//  count          = 2 //length(data.aws_availability_zones.available.names)
//  subnet_id      = element(aws_subnet.private_lab.*.id, count.index)
//  route_table_id = element(aws_route_table.private_route.*.id, count.index)
//}