apt update
apt install unzip

wget https://github.com/ossrs/srs/archive/v2.0-r2.tar.gz
tar -xzf v2.0-r2.tar.gz
cd srs-2.0-r2/trunk
./configure
make -j2
make install
sudo ln -sf /usr/local/srs/etc/init.d/srs /etc/init.d/srs
/etc/init.d/srs start
