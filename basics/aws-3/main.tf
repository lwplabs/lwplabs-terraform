# create VPC

resource "aws_vpc" "prod" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "prod"
    Created = "Terrform"
  } 
}

# Subnets public
resource "aws_subnet" "prod-public-1" {

  ## fetch the vpc id from the above created resource
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"


  tags = {
    Name = "prod-public-1"
  }
}

resource "aws_subnet" "prod-public-2" {
  ## fetch the vpc id from the above created resource
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"


  tags = {
    Name = "prod-public-2"
  }
}

# Subnets private
resource "aws_subnet" "prod-private-1" {
  ## fetch the vpc id from the above created resource
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"


  tags = {
    Name = "prod-private-1"
  }
}

resource "aws_subnet" "demo-private-2" {
  ## fetch the vpc id from the above created resource
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"


  tags = {
    Name = "prod-private-2"
  }
}

