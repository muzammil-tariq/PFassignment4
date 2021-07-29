FROM ubuntu:20.04 AS builder

# Update --------------------------------------

RUN apt-get update

#Download PM2
RUN apt install npm

RUN npm install pm2 -g

# Download Nginx and Sql ------------------------

RUN apt-get install nginx -y \
   &&  apt-get install php7.4-fpm -y \
   && apt-get install mysql-server -y

# Host our Php file ------------------------

COPY nginxConf/info.php  /var/www/html

# Add Configuration -------------------------

ADD nginxConf/default /etc/nginx/sites-available/default

# Expose Ports --------------------------------

EXPOSE 80 81 3306 


# Entry Point ----------------------------

COPY ./script.sh /

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]

