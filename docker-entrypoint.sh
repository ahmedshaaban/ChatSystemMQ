#!/bin/bash
set -e
./wait-for-it.sh $MYSQL_HOSTNAME:3306 
RAKE_ENV=development rake db:create 
RAKE_ENV=development rake db:migrate

exec "$@"