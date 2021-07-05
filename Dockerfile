FROM ubuntu:20.04 AS builder

# Update --------------------------------------

RUN apt-get update

# Download msmtp ------------------------------
RUN apt update && apt install -y \
	msmtp \
	openssl \
	ca-certificates


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

# DOWNLOAD CERTS -------------------------

RUN update-ca-certificates

RUN ln -sf /usr/bin/msmtp /usr/sbin/sendmail

COPY mail/msmtprc /etc

# Entry Point ----------------------------

COPY ./script.sh /

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
