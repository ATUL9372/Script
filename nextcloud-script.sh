#!/bin/bash

# Create automatic Script to Install Nextcloud any linux os 

echo +========================================================+

echo "   Install Automatic Nextcloud Script Fress Linux OS  "

echo +========================================================+

# variables

done="done"             
suuser=" ----->  please Enter your sudo/root user password  <-----"    # root user

# install apache2 webserver 

sudo apt-get install apache2 -y
echo "install apache2 " $done
# update your linux system

sudo apt-get update   # update linux os

echo " update successful " $done
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo "installing MYSQL and PHP 7.4"
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sudo apt install apache2 mysql-server libapache2-mod-php7.4 
sudo apt install php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl
sudo apt install php7.4-gmp php7.4-bcmath php-imagick php7.4-xml php7.4-zip

echo "installed all php files" $done

echo ++++++++++++++++++++++++++++++++++++++++
echo  "Create MYSQL Databases;"ln -s  /etc/apache2/site-available/nextcloud.conf  /etc/apache2/site-enable
echo ++++++++++++++++++++++++++++++++++++++++

# echo $suuser                    # root user enter your password

# sudo mysql -u root -p
mysql -u root --execute="CREATE USER 'username1'@'localhost' IDENTIFIED BY 'password';"   # create  users for nextcloud in databases
mysql -u root --execute="CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;" # create databases
mysql -u root --execute="GRANT ALL PRIVILEGES ON nextcloud.* TO 'username1'@'localhost';"  # full privileges
mysql -u root --execute="FLUSH PRIVILEGES;"
# mysql -u root --execute="quit;"                                                         # exit

echo ========================================================================================================

echo " Database Name :- nextcloud || Database Username :- username1  ||  Database Password :- password  "

echo ========================================================================================================
echo "Database is " $done

# /var/www/ 
cd /var/www/ || exit
wget https://download.nextcloud.com/server/releases/nextcloud-23.0.2.tar.bz2 

echo "nextcloud Download is " $done
cd /var/www/ || exit
tar -xjvf nextcloud-23.0.2.tar.bz2
echo "extracting all files is " $done
# $NEXTCLOUD_DIR="/var/www/nextcloud"
# cd $NEXTCLOUD_DIR || exit

echo "var files is $done but chown miss please wait "

echo ==================================================
echo "Starting Apache Config File"
echo ==================================================
cd /etc/apache2/sites-available 
touch nextcloud.conf

# The cat <<EOF syntax is very useful when working with multi-line text in Bash, eg. when assigning multi-line string to a shell variable, file or a pipe.
cat >/etc/apache2/sites-available/nextcloud.conf <<EOF
Alias /nextcloud "/var/www/nextcloud/"

<Directory /var/www/nextcloud/>
  Require all granted
  AllowOverride All/etc/apache2/site-enable
  Options FollowSymLinks MultiViews

  <IfModule mod_dav.c>
    Dav off
  </IfModule>
</Directory>
EOF

echo "nextcloud.conf file is  " $done

echo =========================
echo "a2enmod Starting"
echo =========================

cd /etc/apache2/sites-available/

sudo a2ensite nextcloud.conf
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime
sudo a2enmod setenvif
echo "check lines "


sudo apachectl configtest
echo "apache config" $done
sudo service apache2 restart
echo "apache2 restart" $done

sudo a2enmod ssl
sudo a2ensite default-ssl
sudo service apache2 reload

echo "last changes in var files "
sudo chown -R www-data:www-data /var/www/nextcloud/
sudo systemctl restart apache2

echo "please check all lines "
echo "check /etc/apache2/site-enabled file some time not creat symbolic link"
echo "cd site-enable  ln -s  /etc/apache2/site-available/nextcloud.conf  /etc/apache2/site-enable"
echo "open firfox and type http://localhost/nextcloud"
echo "enjoy"








