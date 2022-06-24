# Update Dynamic IP
Store the current ip of a local system on a remote server.

## Setup
### Server
1) Install apache, php and postgresql:
```sh
sudo apt-get install apache2 -y
sudo apt-get install php -y
sudo apt-get install php-pgsql -y
sudo apt-get install libapache2-mod-php -y
sudo apt-get install postgresql -y
```
2) Set a new password for the database (replace `DATABASE_PASSWORD_HERE`):
```sh
sudo -u postgres psql -c "ALTER user postgres WITH password 'DATABASE_PASSWORD_HERE';"
```
3) Edit `postgresql.conf`, located in `/etc/postgresql/POSTGRESQLVERSION/main`, and change `#listen_addresses = 'localhost'` to `listen_addresses = '*'` to allow remote connections.
4) In the same folder, edit `pg_hba.conf` and replace `host all all 127.0.0.1/32 md5` with `host all all 0.0.0.0/0 md5`.
5) Restart services to apply changes:
```sh
service postgresql restart
service apache2 restart
```
6) Copy `ip.php` from [remote_system](remote_system) to `/var/www/html`.
7) Copy `table.sql` from [remote_system](remote_system) to `/tmp`.
8) Create the database (replace `DBNAME`):
```sh
sudo -u postgres psql -c "create database DBNAME;"
sudo -u postgres psql -d DBNAME -c "\i '/tmp/table.sql';"
```

### Client
1) Install Docker.
2) Navigate to [local_system](local_system).
3) Copy or rename `config.ini.template` to `config.ini` and enter the necessary infos.
4) Build the docker image:
```sh
docker build -t updatedynamicip:1 .
```
5) Create a container from the docker image:
```sh
docker create updatedynamicip:1
```

## Usage
Run the docker container on the local system to update the ip in the remote system database.
