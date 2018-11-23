#!/bin/sh
# This script is made by zhaoshuai in 20160222.
# Open the tomcat' catalina.out log.
TOMCAT_DIR=/usr/local/tomcat1
tail -f $TOMCAT_DIR/logs/catalina.out 
