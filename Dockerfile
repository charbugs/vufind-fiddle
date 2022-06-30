FROM debian:bullseye

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y git zip unzip default-jdk default-mysql-server python3 wget php php-mbstring php-pear php-dev php-gd php-intl php-json php-ldap php-mysql php-soap php-xml php-curl php-xdebug composer

# NodeJS
WORKDIR /tmp
# Some of the node dependencies can only be compiled by this specific node version
RUN wget https://nodejs.org/download/release/v17.9.1/node-v17.9.1-linux-x64.tar.xz
RUN tar xf node-v17.9.1-linux-x64.tar.xz
RUN ln -s /tmp/node-v17.9.1-linux-x64/bin/* /usr/local/bin

# XDebug
RUN echo "[xdebug]" >> /etc/php/7.4/cli/php.ini
RUN echo "xdebug.mode=debug" >> /etc/php/7.4/cli/php.ini
RUN echo "xdebug.client_port=9003" >> /etc/php/7.4/cli/php.ini
RUN echo "xdebug.start_with_request=yes" >> /etc/php/7.4/cli/php.ini
# xdebug.client_host must be set to the docker bridge ip. 
# This must be done in docker-run.sh
# change access to php.ini as docker-run.sh runs as user
RUN chmod 666 /etc/php/7.4/cli/php.ini

RUN useradd -ms /bin/bash vufind
USER vufind
WORKDIR /vufind

# Web server
EXPOSE 8080
# Solr
EXPOSE 8983