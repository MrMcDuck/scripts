# Reference: https://www.postgresql.org/download/linux/ubuntu/

# Add source list for postgresql
sudo vi /etc/apt/sources.list.d/pgdg.list # Create source list file
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main # Add this line into source list file for the repository
# Import the repository signing key, and update the package lists
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add -

# Install
sudo apt-get update # Update source list
apt-get install postgresql-9.6

# Allow remote access
sudo vi /etc/postgresql/9.6/main/postgresql.conf # You can change listen port (5432) in this conf file if you need it
listen_addresses = '*' # Find '#listen_addresses = 'localhost'', change to this
sudo vi /etc/postgresql/9.6/main/pg_hba.conf
host  all  all  192.168.0.0/16  md5 # Allow 192.168.*.* access all database with any user, login auth method is md5. If 192.168.9.* is allowed, using 192.168.9.0/24 instead.

# Change password
sudo -u postgres psql # Login pgsql command line client with default user 'postgres'
ALTER USER postgres WITH PASSWORD '&^12gkA'; # '' and ; are needed
\q # quit command line client

# Restart service
service postgresql restart