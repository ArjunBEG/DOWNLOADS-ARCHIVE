# You probably shouldn't use this

rm -f `which redis-server`
wget http://redis.googlecode.com/files/redis-2.4.10.tar.gz
tar -xf redis-2.4.10.tar.gz
cd redis-2.4.10
make && make install