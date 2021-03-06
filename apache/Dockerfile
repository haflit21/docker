FROM debian:jessie

RUN echo "deb http://ftp.es.debian.org/debian stable main contrib non-free" > /etc/apt/sources.list
RUN echo "deb-src http://ftp.es.debian.org/debian stable main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://ftp.debian.org/debian/ wheezy-updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.debian.org/debian/ wheezy-updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://security.debian.org/ wheezy/updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://security.debian.org/ wheezy/updates main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update && apt-get -y install apache2 libapache2-mod-fastcgi && apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ADD config/vhost.conf /etc/apache2/sites-available/
ADD config/fastcgi.conf /etc/apache2/mods-available/

RUN /bin/ln -sf ../mods-available/socache_shmcb.load /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../mods-available/ssl.conf /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../mods-available/ssl.load /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../mods-available/actions.load /etc/apache2/mods-enabled/

RUN /bin/ln -sf ../sites-available/default-ssl /etc/apache2/sites-enabled/001-default-ssl
RUN /bin/ln -sf ../sites-available/vhost.conf /etc/apache2/sites-enabled/

RUN usermod -u 1000 www-data

EXPOSE 80
EXPOSE 443

RUN a2enmod proxy \
	&& a2enmod proxy_fcgi \
	&& a2enmod actions\
	&& a2enmod rewrite

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]