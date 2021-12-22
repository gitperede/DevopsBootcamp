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

# Installing Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo amazon-linux-extras install epel -y
sudo yum install java-1.8.0-openjdk -y
sudo yum install jenkins -y
sudo service jenkins start
sudo echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Installing Ansible
sudo amazon-linux-extras install ansible2
