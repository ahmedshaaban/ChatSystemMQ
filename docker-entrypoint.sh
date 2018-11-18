#!/bin/bash
set -e
./wait-for-it.sh $DB_HOSTNAME:3306 
bundle install
RAKE_ENV=development rake db:create 
RAKE_ENV=development rake db:migrate

exec "$@"