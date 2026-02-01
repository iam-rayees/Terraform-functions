#!/bin/bash
set -euxo pipefail
exec > /var/log/user-data.log 2>&1

apt-get update -y
apt-get install -y nginx git

cd /tmp
git clone https://github.com/iam-rayees/Cloud-Spectrum-Master.git

rm -f /var/www/html/index.nginx-debian.html
cp /tmp/Cloud-Spectrum-Master/index.html /var/www/html/index.html
cp /tmp/Cloud-Spectrum-Master/style.css /var/www/html/style.css
cp /tmp/Cloud-Spectrum-Master/script.js /var/www/html/script.js

systemctl restart nginx
systemctl enable nginx

#Testing 

#Testing

#Testing

