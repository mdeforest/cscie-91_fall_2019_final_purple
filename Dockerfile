FROM centos:7

RUN yum update -y && yum install httpd -y
EXPOSE 80

COPY ./index.html /var/www/html/
COPY ./images /var/www/images/

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
