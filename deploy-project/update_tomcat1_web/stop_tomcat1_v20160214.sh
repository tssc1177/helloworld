#!/bin/sh
# This script is made by zhaoshuai in 20160214.
TOMCAT_DIR="/usr/local/tomcat1"
# Stop the tomcat1.
echo "Now stop the tomcat1."
ps -ef | grep "$TOMCAT_DIR" | grep -v grep | awk '{print $2}' | sed -e "s/^/kill -9 /g" | sh -
ps -ef | grep "$TOMCAT_DIR"
sleep 1
echo " "
echo "The tomcat1 is stop."
