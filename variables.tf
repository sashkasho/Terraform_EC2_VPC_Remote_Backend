variable "instance_type" {
    type = string
}
variable "aws_security_group_name" {
    type = string
}
variable "aws_security_group_description" {
    type = string
}
variable "server_count" {
    type = number
    default = "1"
}
variable "secondary_private_ips" {
    type = list(string)
}
variable "protocol_tcp" {
    type = string
}
variable "security_group_cidr_blocks" {
    type = list(string)
}
variable "aws_key_pair_name" {
    type = string
}
variable "aws_key_pair_public" {
    type = string
}
