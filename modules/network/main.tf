# NETWORK BLOCKS
resource "aws_vpc" "test_vpc" {
  cidr_block       = var.aws_vpc_cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.aws_subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
  
  tags = {
    Name = "test_subnet"
  }
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test_igw"
  }
}

resource "aws_route_table" "test_rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = var.aws_route_table_route_cidr
    gateway_id = aws_internet_gateway.test_igw.id
  }

  tags = {
    Name = "test_rt"
  }
}

resource "aws_route_table_association" "test_rt_assoc" {
  subnet_id      = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_rt.id
}