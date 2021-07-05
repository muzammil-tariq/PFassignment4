#!/bin/sh


service nginx start

service mysql start

service php7.4-fpm start


while true; do sleep 1000; done

