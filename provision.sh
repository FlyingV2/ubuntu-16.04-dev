#!/bin/bash
sudo service vboxadd start

echo "Provisioning virtual machine..."

# Update repos, upgrade and install basic utilities
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

sudo apt-get install -y software-properties-common build-essential python-setuptools python-pip python-virtualenv libssl-dev tcl curl git vim nginx

# Install Node Version Manager (NVM)
git clone https://github.com/creationix/nvm.git
./nvm/install.sh
source ~/.profile
sudo rm -r nvm
nvm install 6.11.0

# Configure .vim/.vimrc
wget https://gist.githubusercontent.com/FlyingV2/accd602b4c021830652a/raw/5e07386774cd79da22eb61b7348c97d2c1198125/.vimrc
mkdir -p ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
git clone https://github.com/tpope/vim-pathogen.git ~/.vim/vim-pathogen
cp -r ~/.vim/vim-pathogen/autoload ~/.vim/autoload
sudo rm -r ~/.vim/vim-pathogen

# Install Redis / Refer to README.md for configuration instructions after provisioning
# curl -O http://download.redis.io/redis-stable.tar.gz
# tar xzvf redis-stable.tar.gz
# cd redis-stable
# make
# make test
# sudo make install
# cd
# sudo rm redis-stable.tar.gz

# Install MariaDB / Refer to README.md for "mysql_secure_installation" instructions after provisioning.
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.2/ubuntu xenial main'
sudo apt-get update
# sudo apt-get install mariadb-server

#Install PHP7
sudo apt-get install php7.0-dev php7.0-fpm php7.0-mbstring php7.0-xml php7.0-mysql php7.0-common php7.0-gd php7.0-json php7.0-cli php7.0-curl php7.0-zip php-xdebug
sudo systemctl start php7.0-fpm

# Download and install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
sudo rm composer-setup.php

echo ""
echo ""
echo "Provisioning completed! Please run: vagrant reload"