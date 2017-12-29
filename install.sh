#!/bin/bash
./install-deps.sh
mkdir build 2>/dev/null
cd build
rm *.*
rm *
if which qmake >/dev/null; then
  echo "Found qmake"
else
  echo "Installing qmake"
  INSTALLED=false
  if which apt >/dev/null; then
    apt install qt5-qmake || echo "Could not install qmake. Are you running this script as root?"
    apt install qt5-default || echo "Could not install qmake. Are you running this script as root?"
    INSTALLED=true
  fi
  if which yum >/dev/null; then
    yum install qt5-qmake || echo "Could not install qmake. Are you running this script as root?"
    yum install qt5-default || echo "Could not install qmake. Are you running this script as root?"
    INSTALLED=true
  fi
  if $INSTALLED; then
     echo "Successfully installed qmake"
  else 
        echo "Could not find a package manager. Please install qmake manually."
  fi
fi
if which make >/dev/null; then
  echo "Found make"
else
  echo "Installing make"
  INSTALLED=false
  if which apt >/dev/null; then
    apt install build-essentials || echo "Could not install make. Are you running this script as root?"
    INSTALLED=true
  fi
  if which yum >/dev/null; then
    yum install build-essentials || echo "Could not install make. Are you running this script as root?"
    INSTALLED=true
  fi
  if $INSTALLED; then
     echo "Successfully installed make"
  else 
        echo "Could not find a package manager. Please install make manually."
  fi
fi
qmake ../
make 2>&1 > /dev/null
./ODS2TTS
