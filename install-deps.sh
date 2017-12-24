#!/bin/sh
# Bash script to install dependencies
cd /tmp
git clone https://github.com/dstosberg/odt2txt
cd odt2txt
make install || echo "Could not install odt2txt. Are you running this script as root?"
if which pico2wave >/dev/null; then
	echo "Found pico2wave..."
else
    echo "Installing libttspico-utils"
    INSTALLED=false
    if which apt >/dev/null; then
        apt install libttspico-utils || echo "Could not install libttspico-utils. Are you running this script as root?"
        INSTALLED=true
    fi
    if which yum >/dev/null; then
        yum install libttspico-utils || echo "Could not install libttspico-utils. Are you running this script as root?"
        INSTALLED=true
    fi
    if $INSTALLED; then
        echo "Successfully installed libttspico-utils"
    else 
        echo "Could not find a package manager. Please install libttspico-utils manually."
    fi
fi

if which pico2wave >/dev/null; then
    echo "Dependencies installed!"
else
    echo "Dependencies installation failed"
fi