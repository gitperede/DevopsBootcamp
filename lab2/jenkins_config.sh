sudo rm -rf nasapicoftheday/
sudo git clone https://github.com/gitperede/nasapicoftheday.git
sudo cp -rv nasapicoftheday/* /var/www/html
sudo ansible-playbook /home/webtesting.yaml
