#!/usr/bin/env bash

# Set up the required build tools
sudo apt install build-essential autoconf libtool bison re2c pkg-config libxml2-dev libreadline-dev -y

# Get the binaries package
cd /tmp || exit
wget https://www.php.net/distributions/php-8.1.10.tar.xz

# Extract the source code
mkdir php-src
sudo tar -xJvf php-8.1.10.tar.xz -C php-src
cd php-src/php-8.1.10 || exit
sudo chown -R "$(id -u):$(id -g)" .

# Configure Php
./buildconf
./configure \
    --prefix=/usr/local/lib/php \
    --disable-cgi \
    --without-pear \
    --without-sqlite3 \
    --without-pdo-sqlite \
    --with-readline

# Compile Php
sudo make -j "$(nproc)" clean
sudo make -j "$(nproc)" install

# Delete the source
sudo rm -rf /tmp/php-src
sudo rm -rf /tmp/php-8.1.10.tar.xz
