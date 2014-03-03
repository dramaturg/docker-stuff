
FROM centos

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>


RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum -y update

RUN yum -y install mysql mysql-server mysql-devel

ADD my.cnf /etc/my.cnf
ADD start_mysql.sh /root/start_mysql.sh
RUN chmod 700 /root/start_mysql.sh

EXPOSE 3306
CMD ["/root/start_mysql.sh"]

