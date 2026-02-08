#!/bin/bash
set -e

sudo apt-get update -y
sudo apt-get install -y nginx
rm -f /var/www/html/index.nginx-debian.html

echo "<h1>It works from user_data on Public_servers!</h1>" > /var/www/html/index.html

sudo systemctl restart nginx
sudo systemctl enable nginx

#Testing
#Testing
#Testing

