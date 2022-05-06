#!/bin/bash
# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# Installation of Weblogic domain on private subnet

sudo /usr/bin/yum -y install tigervnc-server.x86_64
sudo /usr/bin/yum -y install tigervnc.x86_64
sudo /usr/bin/yum -y groups install "Server with GUI"

# Switch to appropriate user
/usr/bin/mkdir -p /home/opc/.config/gconf
/usr/bin/gconftool-2 -s -t bool /apps/gnome-screensaver/lock_enabled false

# start vnc

/usr/bin/mkdir -p /home/opc/.vnc
/usr/bin/touch /home/opc/.vnc/passwd
sudo /usr/bin/chown opc:opc /home/opc/.vnc/passwd
sudo /usr/bin/chmod 777 /home/opc/.vnc/passwd
/usr/bin/echo "mysecret" | /usr/bin/vncpasswd -f > /home/opc/.vnc/passwd
sudo /usr/bin/chmod 600 /home/opc/.vnc/passwd

/usr/bin/rm -rf /tmp/.X11*


/usr/bin/vncserver :1 -depth 16 -alwaysshared -geometry 1200x750 -s off
/usr/bin/sleep 2;
/usr/bin/sudo iptables -F

