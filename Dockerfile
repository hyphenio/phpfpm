FROM ubuntu:latest
MAINTAINER Hyphen IO <services@hyphenio.com.au>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list

RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" >> /etc/apt/sources.list

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com --recv 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C

RUN apt-get update && apt-get -y dist-upgrade && apt-get -y install php7.0 php7.0-fpm php7.0-tidy php7.0-xml php7.0-gd php7.0-mbstring php7.0-curl php7.0-mysql php7.0-mcrypt && apt-get clean && apt-get autoclean && apt-get autoremove

WORKDIR /opt/app
RUN echo "#!/bin/bash" > /usr/local/bin/entry.sh
RUN echo "/usr/sbin/php-fpm7.0 --nodaemonize -y /opt/app/server/fpm/php-fpm.conf -c /opt/app/server/php" >> /usr/local/bin/entry.sh
RUN chmod 777 /usr/local/bin/entry.sh

EXPOSE 9000
CMD ["/usr/local/bin/entry.sh"]
