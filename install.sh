#!/usr/bin/env bash

source /etc/os-release
INSTALLDIR=/opt/instinctual/pennypincher

cd "$(dirname "$0")"

  if [[ $VERSION_ID = "8" ]]
    then
      echo "Turning off Nvidia keywords in Xorg"
      sed -i 's/Option      "RegistryDwords"/# &/' /etc/X11/xorg.conf

      #Create PennyPincher directory
      mkdir -p $INSTALLDIR

      #Install PennyPincher files
      install -m 555 pennypincher.sh $INSTALLDIR
      install -m 555 pennypincher.desktop /etc/xdg/autostart/

      ##Install PennyPincher systemd service.
      install -m 644 pennypincher.service /etc/systemd/system/
      systemctl enable --now pennypincher.service

      echo "PennyPincher sucessfully installed."
      echo "PennyPincher on `date`" >> `dirname $INSTALLDIR`/changelog
    else
      echo "Sorry, only CentOS 8.X supported."
    fi
