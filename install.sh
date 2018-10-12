#/bin/bash
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
BLUE='\033[1;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}Installer:${NC} Will update system"

sudo apt update
sudo apt -y upgrade

echo -e "${GREEN}Installer:${NC} Will install Apache"

sudo apt install -y apache2 apache2-utils
sudo chown www-data:www-data /var/www/html/ -R

echo -e "${GREEN}Installer:${NC} Will install MariaDB"

sudo apt install -y mariadb-server mariadb-client
sudo mysql_secure_installation

echo -e "${GREEN}Installer:${NC} Will install PHP"

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php -y

sudo apt install -y php7.1 libapache2-mod-php7.1 php7.1-mysql php-common php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-readline php7.1-mbstring php7.1-xml
sudo a2enmod php7.1

sudo systemctl restart apache2
sudo systemctl enable apache2

echo -e "${GREEN}Installer:${NC} Will install MediaWiki"

cd /var/www/html/
sudo wget https://releases.wikimedia.org/mediawiki/1.31/mediawiki-1.31.1.tar.gz
sudo tar xvzf mediawiki-*.tar.gz
sudo cp ./mediawiki-*/* ./ --recursive
sudo rm ./mediawiki-* -rf

echo -e "${GREEN}Installer:${NC} Will prepare DB for MediaWiki"

sudo mariadb -u root -e "CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'wiki';"
sudo mariadb -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'wiki'@'localhost';"
sudo mariadb -u root -e "FLUSH PRIVILEGES;"

echo -e "${GREEN}Installer:${NC} Will copy configuration file"

# TODO

echo -e "${GREEN}Installer:${NC} Will set ownership and rights"

sudo chown www-data:www-data /var/www/html/ --recursive
sudo chmod 755 /var/www/html/ --recursive