#!/bin/sh
# Bash script to install dependencies
cd /tmp
git clone https://github.com/dstosberg/odt2txt
cd odt2txt
sudo make install
libttspico-utils