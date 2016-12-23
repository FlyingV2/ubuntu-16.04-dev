# Update repos, upgrade and install basic utilities
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install software-properties-common build-essential tcl libssl-dev curl git vim libkrb5-dev

# Install Python related stuff
sudo apt-get install python-setuptools python-pip python-virtualenv

# Install Nginx
sudo apt-get install nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Install Node Version Manager (NVM)
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
source ~/.profile
nvm install node

# Install Redis / Refer to README.md for configuration instructions after provisioning
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
make test
sudo make install
cd
sudo rm redis-stable.tar.gz

# Install MariaDB / Refer to README.md for "mysql_secure_installation" instructions after provisioning.
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.osuosl.org/pub/mariadb/repo/10.1/ubuntu xenial main'
sudo apt-get update
# sudo apt-get install mariadb-server

#Install PHP7
sudo apt-get install php7.0-dev php7.0-fpm php7.0-mbstring php7.0-xml php7.0-mysql php7.0-common php7.0-gd php7.0-json php7.0-cli php7.0-curl php7.0-zip php-xdebug
sudo systemctl start php7.0-fpm

# Download and install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
sudo rm composer-setup.php
sudo chown -R ubuntu:ubuntu ~/.composer
# chmod 775 -R ~/.composer

# Configure .vim/.vimrc
wget https://gist.githubusercontent.com/vincepreziose/accd602b4c021830652a/raw/176347322f56b1dfe0c3b41d53fbb4f4235aae76/.vimrc
mkdir -p ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
git clone https://github.com/tpope/vim-pathogen.git ~/.vim/vim-pathogen
cp -r ~/.vim/vim-pathogen/autoload ~/.vim/autoload
sudo rm -r ~/.vim/vim-pathogen