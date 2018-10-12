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

sudo apt install -y php7.0 libapache2-mod-php7.0 php7.0-mysql php-common php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-readline php7.0-mbstring php7.0-xml
sudo a2enmod php7.0

sudo systemctl restart apache2
sudo systemctl enable apache2

echo -e "${GREEN}Installer:${NC} Will install MediaWiki"

cd /var/www/html/
sudo wget https://releases.wikimedia.org/mediawiki/1.31/mediawiki-1.31.1.tar.gz
sudo tar xvzf mediawiki-*.tar.gz
sudo cp ./mediawiki-*/* ./ --recursive
sudo rm ./mediawiki-* -rf
