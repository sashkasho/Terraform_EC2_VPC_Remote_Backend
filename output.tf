output "server_ip" {
    value = aws_instance.test_server[0].public_ip
}
output "server_endpoint" {
    value = "http://${aws_instance.test_server[0].public_dns}"
}
output "my_home_ip" {
    value = chomp(data.http.my_home_ip.response_body)
}