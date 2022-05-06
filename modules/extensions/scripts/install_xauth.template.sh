#!/bin/bash
# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# Enable X11 Forwarding 

sudo /usr/bin/yum -y install xorg-x11-xauth > /dev/null 2>&1
sudo /usr/bin/yum  -y install xterm > /dev/null 2>&1
sudo /usr/bin/yum  -y install xclock > /dev/null 2>&1
sudo yum -y install atk java-atk-wrapper at-spi2-atk gtk3 libXt libdrm mesa-libgbm  > /dev/null 2>&1
sudo service sshd restart
# export DISPLAY=<IP_LAPTOP>:10.0 -- get the IP of your laptop wher xming is running