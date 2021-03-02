FROM amazonlinux:2

# PHP
RUN amazon-linux-extras enable php7.4
RUN yum clean metadata
RUN yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap,pgsql} -y

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN ln -s /usr/local/bin/composer /usr/bin/composer

# Node
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install nodejs -y

# httpd
RUN yum install -y httpd

# copy file config
COPY envConfig/caremall.conf /etc/httpd/conf.d/

CMD [ "/usr/sbin/httpd", "-DFOREGROUND" ]