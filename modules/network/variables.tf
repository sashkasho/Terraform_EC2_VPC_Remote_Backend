variable "aws_vpc_cidr_block" {
  type = string
}
variable "aws_subnet_cidr_block" {
  type = string
}
variable "availability_zone" {
  type = string
}
variable "enable_dns_support" {
  type = bool
  default = true
}
variable "enable_dns_hostnames" {
  type = bool
  default = true
}
variable "map_public_ip_on_launch" {
  type = bool
  default = true
}
variable "aws_route_table_route_cidr" {
  type = string
}