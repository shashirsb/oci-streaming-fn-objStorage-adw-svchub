#!/bin/bash
# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# Installing latest version of WebLogic Kubernetes Toolkit Ui
export WKTUI_VERSION=$(curl -s https://github.com/oracle/weblogic-toolkit-ui/releases/latest  | awk -F'/v' '{print $2}' |awk -F'"' '{print $1}')
/usr/bin/wget https://github.com/oracle/weblogic-toolkit-ui/releases/download/v$WKTUI_VERSION/wktui-$WKTUI_VERSION.x86_64.rpm
sudo /usr/bin/yum -y localinstall wktui-$WKTUI_VERSION.x86_64.rpm > /dev/null 2>&1
export LIBGL_ALWAYS_INDIRECT=1	

# export WDT_VERSION=$(curl -s https://github.com/oracle/weblogic-deploy-tooling/releases/latest  | awk -F'/release-' '{print $2}' |awk -F'"' '{print $1}')
# /usr/bin/wget https://github.com/oracle/weblogic-deploy-tooling/releases/download/release-$WDT_VERSION/weblogic-deploy.zip
# /usr/bin/unzip weblogic-deploy.zip
# /usr/bin/rm weblogic-deploy.zip
sudo iptables -F

echo "wktui completed"
