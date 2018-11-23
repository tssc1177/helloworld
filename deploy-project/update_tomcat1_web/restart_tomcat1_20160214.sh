#!/bin/sh
# This script is made by zhaoshuai in 20160214.
######################   BEGIN   ############################
TIME=$(date +%Y%m%d-%H%M)
TOMCAT_DIR=/usr/local/tomcat1
# Stop the tomcat1.
echo "Now stop the tomcat1."
ps -ef | grep "$TOMCAT_DIR" | grep -v grep | awk '{print $2}' | sed -e "s/^/kill -9 /g" | sh -
sleep 1
echo " "
echo "The tomcat1 is stop."

/bin/mv      $TOMCAT_DIR/logs/catalina.out /tmp/tomcat1-$TIME.log
/bin/rm -rf $TOMCAT_DIR/logs/*
/bin/rm -rf $TOMCAT_DIR/work/*

# Start Tomcat Server
echo "Now start tomcat1 server"
$TOMCAT_DIR/bin/catalina.sh start
ps -ef | grep "$TOMCAT_DIR" | grep -v grep

tail -f $TOMCAT_DIR/logs/catalina.out
####################   END   #######################

