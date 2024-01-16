#!/bin/bash
yum update -y
sudo amazon-linux-extras install nginx1
systemctl enable nginx
sudo mkdir -p /var/www/wrnd.com/html
sudo mkdir -p /var/www/wrnd-dev.com/html
sudo chmod -R 755 /var/www
cd /etc/nginx/conf.d
aws s3 cp s3://will-artefatos/wrnd.conf .
cd /var/www/wrnd/html/
aws s3 cp s3://will-artefatos/index.html .
cd /var/www/wrnd-dev.com/html/
aws s3 cp s3://will-artefatos/index.html .
systemctl restart nginx