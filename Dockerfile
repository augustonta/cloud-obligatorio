FROM php:5.4.33-apache
RUN apt-get -y update
RUN apt-get install git -y --force-yes
WORKDIR /var/www/html/
RUN mkdir /var/www/html/documents
RUN git clone https://github.com/augustonta/simple-ecomme.git && rsync -a simple-ecomme/ . && rm -rf simple-ecomme
