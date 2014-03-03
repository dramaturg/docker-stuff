#!/bin/bash 

set -e

password="new-password"

if [ -d /var/lib/mysql/mysql ] ; then 
   /usr/bin/mysqld_safe
else
   chown mysql.mysql /var/lib/mysql/

   /usr/bin/mysql_install_db

   cd /usr 
   /usr/bin/mysqld_safe &
   sleep 5

   /usr/bin/mysqladmin password "$password"
   /usr/bin/mysqladmin --password="$password" shutdown

   wait $!
fi


