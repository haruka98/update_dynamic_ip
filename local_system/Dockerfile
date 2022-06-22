# use debian 11.3 as base
FROM debian:11.3

# update apt
RUN apt-get update

# install the postgresql client
RUN apt-get install postgresql-client -y

# install wget
RUN apt-get install wget -y

# copy the config file
COPY config.ini /tmp/

# copy the script
COPY update_ip.sh /tmp/

# run the script on startup
CMD ["/tmp/update_ip.sh"]
