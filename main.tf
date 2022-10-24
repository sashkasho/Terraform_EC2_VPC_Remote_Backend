provider "aws" {
  region = "ca-central-1"
}

# DATA BLOCKS
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
   filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "userdata_sh" {
  template = file("./scripts/userdata.sh")
  vars = {
    vpc_id = module.network_block.vpc_id
  }
}

data "http" "my_home_ip"{
  url = "http://ipv4.icanhazip.com"
}

# NETWORK MODULE
module "network_block" {
  source = "./modules/network"
  aws_vpc_cidr_block = "10.0.0.0/16"
  aws_subnet_cidr_block = "10.0.1.0/24"
  availability_zone = "ca-central-1a"
  enable_dns_support = true
  enable_dns_hostnames = true
  map_public_ip_on_launch = true
  aws_route_table_route_cidr = "0.0.0.0/0"
}

# SERVER BLOCKS
resource "aws_instance" "test_server" {
  count = var.server_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  subnet_id = module.network_block.subnet_id
  secondary_private_ips = var.secondary_private_ips
  key_name = aws_key_pair.test_key.key_name
  user_data = data.template_file.userdata_sh.rendered

  tags = {
    Name = "test_server"
  }
}

resource "aws_security_group" "test_sg" {
  name        = var.aws_security_group_name
  description = var.aws_security_group_description
  vpc_id      = module.network_block.vpc_id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = var.protocol_tcp
    cidr_blocks      = var.security_group_cidr_blocks
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = var.protocol_tcp
    cidr_blocks      = var.security_group_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.security_group_cidr_blocks
  }

  tags = {
    Name = "test-sg"
  }
}

resource "aws_key_pair" "test_key" {
  key_name   = var.aws_key_pair_name
  public_key = var.aws_key_pair_public
}
