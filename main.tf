resource "aws_vpc" "vpc_main" {
  cidr_block = "10.0.0.0/16"
  tags       = merge(
    local.common_tags,
    { Name = "{muthoot-vpc" }
  )
}

resource "aws_subnet" "public-subnet-a" {
  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.1.0.0/28"
  map_public_ip_on_launch = true
  availability_zone = ["us-east-1a"]

  tags       = merge(
    local.common_tags,
    { Name = "{muthoot--public-SN-b" }
  )
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.2.0.0/28"
  map_public_ip_on_launch = true
  availability_zone = ["us-east-1b"]

  tags       = merge(
    local.common_tags,
    { Name = "{muthoot--public-SN-b" }
  )
}

resource "aws_subnet" "private-subnet-a" {
  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.3.0.0/28"
  availability_zone = ["us-east-1a"]

  tags       = merge(
    local.common_tags,
    { Name = "{muthoot-pri-SN-a" }
  )
}


resource "aws_subnet" "private-subnet-b" {
  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.4.0.0/28"
  availability_zone = ["us-east-1b"]

  tags       = merge(
    local.common_tags,
    { Name = "{muthoot-pri-SN-b" }
  )
}


# creating internetgateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = merge(
    local.common_tags,
    { Name = "{muthoot-igw" }
  )
}


resource "aws_route_table" "r" {
  vpc_id = aws_vpc.vpc_main

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gw.id
  }
