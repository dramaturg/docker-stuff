#!/bin/bash 

set -e

password="new-password"

if [ ! -d /var/run/mysqld/mysql ] ; then 
   chown mysql.mysql /var/run/mysqld/

   /usr/bin/mysql_install_db

   cd /usr 
   /usr/bin/mysqld_safe --skip-networking &
   sleep 5

   /usr/bin/mysqladmin password "$password"
   /usr/bin/mysqladmin --password="$password" shutdown

   wait $!
fi

/usr/bin/mysqld_safe

