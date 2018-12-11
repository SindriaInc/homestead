#!/usr/bin/env bash

declare -A params=$6     # Create an associative array
paramsTXT=""
if [ -n "$6" ]; then
   for element in "${!params[@]}"
   do
      paramsTXT="${paramsTXT}
      fastcgi_param ${element} ${params[$element]};"
   done
fi

if [ "$7" = "true" ] && [ "$5" = "7.2" ]
then configureZray="
location /ZendServer {
        try_files \$uri \$uri/ /ZendServer/index.php?\$args;
}
"
else configureZray=""
fi


cat "/var/www/$1/vendor/sindria/homestead/resources/magento22/nginx/sites-available/sindria-homestead-magento2.2.conf" > "/etc/nginx/sites-available/$1"
cat "/var/www/$1/vendor/sindria/homestead/resources/magento22/php.ini.sample" > "/etc/php/7.1/fpm/php.ini"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
mkdir /var/log/nginx/$1/
touch /var/log/nginx/$1/access.log
touch /var/log/nginx/$1/error.log
systemctl restart php7.1-fpm
systemctl restart nginx
#sudo apt-get install php7.1-mcrypt -y


