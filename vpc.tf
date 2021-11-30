#VPC
resource "aws_vpc" "ecomme-ae-mh" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "VPC ecomme-ae-mh"
  }
}

resource "aws_subnet" "subnet_public_1" {
  vpc_id                  = aws_vpc.ecomme-ae-mh.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet-1"
  }
}
resource "aws_subnet" "subnet_public_2" {
  vpc_id                  = aws_vpc.ecomme-ae-mh.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1e"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "subnet-2"
  }
}


resource "aws_internet_gateway" "gateway_tp" {
  vpc_id = aws_vpc.ecomme-ae-mh.id
  tags = {
    Name        = "tp-gateway"
    Terraform   = "True"
    Description = "Gateway for the web application"
  }
}

resource "aws_default_route_table" "defaultroutetable_tp" {
  default_route_table_id = aws_vpc.ecomme-ae-mh.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway_tp.id
  }
  tags = {
    Name        = "rt-tp"
  }
} 
