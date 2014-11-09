FROM ubuntu:14.04
MAINTAINER Boyan Bonev <b.bonev@redbuffstudio.com>

#Setup container environment parameters
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

#Configure locale.
RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

#Prepare the image
RUN apt-get -y update

#Make our life easy.
RUN apt-get install -y -q python-software-properties software-properties-common bash-completion

#Use Sury's PPA
RUN echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key E5267A6C
RUN apt-get -y update

#Install PHP packages
RUN apt-get install -y -q php5-cli php5-mongo

#Fetch from master.
ADD https://raw.githubusercontent.com/bobthecow/genghis/v2.3.11/genghis.php /www/

CMD [ "php", "-S", "0.0.0.0:80", "/www/genghis.php" ]
