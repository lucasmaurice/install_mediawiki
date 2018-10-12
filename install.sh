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

sudo apt install -y php7.0 libapache2-mod-php7.0 php7.0-mysql php-common php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-readline
sudo a2enmod php7.0

sudo systemctl restart apache2
sudo systemctl enable apache2

cd /var/www/html/