#!/bin/bash
apt update
apt upgrade
apt install apache2 -y
systemctl start apache2
systemctl enable apache2
echo "<h1>This is the page with:</h1><p>VPC ID: ${vpc_id}</p>" > /var/www/html/index.html