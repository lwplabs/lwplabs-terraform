## creating my first vpc
resource "aws_vpc" "prod" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true" 
    tags = {
    Name = "prod"
    Created = "terraform"
    org     = "lwplabs llc"
  }
}

## create public subnet

resource "aws_subnet" "prod-public-1" {

  ## fetch the vpc id from the above created resource
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.zone[0]
  map_public_ip_on_launch = "true"


  tags = {
    Name = "prod-public-1"
  }
}

# Subnets private
resource "aws_subnet" "prod-private-1" {
  ## fetch the vpc id from the above created resource
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.zone[0]
  map_public_ip_on_launch = "false"


  tags = {
    Name = "prod-private-1"
  }
}


# Internet GW
resource "aws_internet_gateway" "prod-gw" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "prod-igw"
  }
}

# route tables
resource "aws_route_table" "prod-public" {
  vpc_id = aws_vpc.prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-gw.id
  }

  tags = {
    Name = "prod-internet"
  }
}

# route associations public
resource "aws_route_table_association" "prod-public-1-a" {
  subnet_id      = aws_subnet.prod-public-1.id
  route_table_id = aws_route_table.prod-public.id
}