#!/bin/sh


service nginx start

#tail -f /dev/stdout /var/log/nginx/access.log && tail -f /dev/stderr /var/log/nginx/error.log   && tail -f /dev/stderr /var/log/mysql/error.log

service mysql start

service php7.4-fpm start

tail -f /var/log/nginx/access.log /var/log/nginx/error.log /var/log/mysql/error.log pm2/logs


while true; do sleep 1000; done

