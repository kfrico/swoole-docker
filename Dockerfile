FROM php:7.2.7-fpm

RUN apt-get update && apt-get install wget libssl-dev libhiredis-dev nghttp2 -y

RUN cd / && \
wget https://github.com/nghttp2/nghttp2/releases/download/v1.32.0/nghttp2-1.32.0.tar.bz2 && \
tar -jxvf nghttp2-1.32.0.tar.bz2 && \
cd nghttp2-1.32.0 && \
./configure && \
make && \
make install 

RUN cd / && \
wget https://github.com/swoole/swoole-src/archive/v4.0.4.tar.gz && \
tar zxvf v4.0.4.tar.gz && \
cd swoole-src-4.0.4 && \
phpize && \
./configure \
--enable-openssl \
--enable-http2 \
--enable-async-redis \
--enable-swoole \
--enable-swoole-static \
--enable-debug \
--enable-swoole-debug \
--enable-trace-log \
--enable-mysqlnd && \
make clean && make && make install

RUN echo "extension=swoole.so" >> /usr/local/etc/php/conf.d/docker-php-ext-swoole.ini


