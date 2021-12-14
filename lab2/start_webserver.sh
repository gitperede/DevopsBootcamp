#! /bin/bash
# Install http server.
# Clone GitHub repository for the Web.
# Move directory contents to web server home.
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
sudo yum install -y git
sudo git clone https://github.com/gitperede/nasapicoftheday.git
sudo mv nasapicoftheday/* /var/www/html
sudo mv /var/www/html/index.php /var/www/html/index.html
