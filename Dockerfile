FROM centos:7

RUN yum update -y && yum install httpd -y
EXPOSE 80

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

COPY    index.html /var/www/html/
