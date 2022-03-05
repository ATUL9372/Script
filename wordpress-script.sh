#!/bin/bash

# run this script fress ubuntu os

# Create automatic Script to Install Nextcloud any linux os 

echo +========================================================+

echo "   Install Automatic Wordpress Script Fress Linux OS  "

echo +========================================================+

install_dir="/var/www/wordpress"  ## for wp-config.php automatic insert db name,username,password usig this variable
sudo systemctl restart mysql
# install mysql databases

mysql -u root --execute="CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -u root --execute="GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
mysql -u root --execute="FLUSH PRIVILEGES;"
# mysql -u root --execute="EXIT;"

echo ========================================================================================================

echo " Database Name :- wordpress  || Database Username :- wordpressuser ||  Database Password :- password  "

echo ========================================================================================================

echo ##############
echo mysql done
echo ##############


echo ------------------------------------------------
echo "Installing Additional PHP Extensions"
echo ------------------------------------------------

sudo apt update
# sudo apt install php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-xmlrpc php7.4-soap php7.4-intl php7.4-zip
sudo apt install php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-xmlrpc php7.4-soap php7.4-intl php7.4-zip

sudo systemctl restart apache2


echo ------------------------------------------------
echo "Apache’s Configuration"
echo ------------------------------------------------

cd /etc/apache2/sites-available 
touch wordpress.conf

cat >/etc/apache2/sites-available/wordpress.conf <<EOF
<Directory /var/www/wordpress/>
	AllowOverride All
</Directory>
EOF 

sudo a2enmod rewrite
sudo apache2ctl configtest
sudo systemctl restart apache2


echo ------------------------------------------------
echo "Downloading AND Install WordPress"
echo ------------------------------------------------

cd /var/www/
wget https://wordpress.org/latest.tar.gz

cd /var/www/
tar -xzvf latest.tar.gz
cd /var/www/wordpress
sudo mv wp-config-sample.php wp-config.php 
cd /var/www/
touch /var/www/wordpress/.htaccess

/bin/sed -i "s/database_name_here/wordpress/g" $install_dir/wp-config.php   # i <insert> s<searching>
/bin/sed -i "s/username_here/wordpressuser/g" $install_dir/wp-config.php
/bin/sed -i "s/password_here/password/g" $install_dir/wp-config.php


# cd /var/www/ || exit
# cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
# cd /var/www/ || exit
# sudo mkdir /var/www/wordpress/wp-content/upgrade

echo ---------------------------------------------------------------------
echo "Downloding Completed But Sometime Show Error please Checkout "
echo ---------------------------------------------------------------------

sudo chown -R www-data:www-data /var/www/wordpress
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "curl -s https://api.wordpress.org/secret-key/1.1/salt/       #run this command"
echo "cd ~/Downloads/wordpress  || nano -l wp-config.php  || line 51 to 59 print all contents of curl"
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# curl https://api.wordpress.org/secret-key/1.1/salt/

var2="sudo nano /var/www/wordpress/wp-config.php"
echo ===================================================================================
echo "enter your databases in this $var2 direcorty "
echo echo " Database Name :- wordpress  || Database Username :- wordpressuser ||  Database Password :- password  "
echo ===================================================================================


sudo systemctl restart apache2











