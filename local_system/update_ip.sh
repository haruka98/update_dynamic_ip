#!/bin/bash

# include the config file
. "/tmp/config.ini"

# get own ip from the remote server
IP=$(wget -O - ${IP_PATH})

# update the ip in the database on the remote server
PGPASSWORD=${DB_PASS} psql -c "UPDATE ip SET ip = '${IP}';" -d ${DB_NAME} -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER}
