#!/bin/sh
# This script is made by zhaoshuai in 20160214.
######################   BEGIN   ############################
TOMCAT_DIR="/usr/local/tomcat1"

# Delete the cache files.
echo "Now start Flush Cache Files"
/bin/rm -rf $TOMCAT_DIR/work/*
/bin/rm -rf $TOMCAT_DIR/logs/*
sleep 1
echo "Flush Cache Files is OK"
sleep 1

# Start Tomcat Server
echo "Now start tomcat server"
$TOMCAT_DIR/bin/catalina.sh start
ps -ef | grep "$TOMCAT_DIR" | grep -v grep
echo "Tomcat Server is OK"
sleep 1

# Open Tomcat Logs
tail -f $TOMCAT_DIR/logs/catalina.out
