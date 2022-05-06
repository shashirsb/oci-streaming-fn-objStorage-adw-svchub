#!/bin/bash
# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# Installation of Weblogic domain on private subnet

cd $HOME;
rm -rf wls installer;

/usr/bin/wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/hd9AQ4EfLUNU9yGzoOtQNvnjDuUivXO27XMb91JshSvTHhmgu_LvpTGRrRDk8pfx/n/sehubjapacprod/b/appdev-wls/o/wls_backup.zip;

/usr/bin/unzip wls_backup.zip -d $HOME ; /usr/bin/mv $HOME/wls_backup/* $HOME/; /usr/bin/rm -rf $HOME/wls_backup*;

 /usr/bin/rm -rf /home/opc/wls/oracle_home/user_projects/domains/base_domain
 
 /usr/bin/wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/7ouzCYj6-zI6pYsPtpG-Y4D6jFVXae89zroZhBr-hA-cKVTD8zKAs40bJyyDzIUB/n/sehubjapacprod/b/appdev-wls/o/base_domain.jar
 
 /home/opc/wls/oracle_home/oracle_common/common/bin/setWlstEnv.sh
 
 /home/opc/wls/oracle_home/oracle_common/common/bin/unpack.sh -domain=/home/opc/wls/oracle_home/user_projects/domains/base_domain -template=/home/opc/base_domain.jar -user_name=weblogic -password=welcome1

 /usr/bin/nohup /home/opc/wls/oracle_home/user_projects/domains/base_domain/startWebLogic.sh &> start.out &
 /usr/bin/sleep 2;
 /usr/bin/nohup /home/opc/wls/oracle_home/user_projects/domains/base_domain/bin/startNodeManager.sh &> start.out &
/usr/bin/sleep 2;
exit;
 
