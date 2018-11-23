#!/bin/sh
#########################################################
# This script is made by zhaoshuai in 20170509.		#
# for update coinnice web				#
# if you have any question please contact QQ:87482287.	#
#########################################################
###################### BEGIN ############################
TIME=$(date +%Y%m%d-%H%M)
TOMCAT_DIR=/usr/local/tomcat1
WEB_ROOT=/www.spotweb.com
CODEDIR=tempdir
. /etc/init.d/functions

# Determine whether the package.
if [ ! -f "$1" -o -z "$1" ] 
   then 
      sleep 1
      action "Code deployment ......" /bin/false
      echo "Please confirm the <*.war>" 
      exit 1
   else
      echo "The <$1> will be deployed"
fi
if [ ! -d "$TOMCAT_DIR$WEB_ROOT" ] 
   then 
      sleep 1
      action "The specified directory <$WEB_ROOT> does not exist" /bin/false
      echo "Please confirm the <$WEB_ROOT>" 
      exit 1
   else
      action "The specified directory <$WEB_ROOT> exist" /bin/true
fi

# Stop the web server.
echo " "
echo "====== Start stop web server ======"
ps -ef | grep "$TOMCAT_DIR" | grep -v grep | awk '{print $2}' | sed -e "s/^/kill -9 /g" | sh -
sleep 1
action "Stop the web server ......" /bin/true

# Del the old web server
/bin/rm -rf $TOMCAT_DIR$WEB_ROOT

# Update the web server
echo " "
sleep 1
echo "====== Start deploying new code ======"
if [ -d ./$CODEDIR ]
   then
      echo "The \"$CODEDIR\" is exist"
   else
      mkdir -p ./$CODEDIR
      echo "The \"$CODEDIR\" is created"
fi
/bin/cp ./$1 ./$CODEDIR
cd ./$CODEDIR
jar xf $1 && /bin/rm -f $1
cd ../
/bin/mv  $CODEDIR $TOMCAT_DIR$WEB_ROOT

/bin/mv $TOMCAT_DIR/logs/catalina.out /tmp/tomcat1-$TIME.log
/bin/rm -rf $TOMCAT_DIR/logs/*
/bin/rm -rf $TOMCAT_DIR/work/*

# www.spotweb.com
#/bin/cp -rf ./$TIME/WEB-INF/classes/config/*.properties  $TOMCAT_DIR$WEB_ROOT/WEB-INF/classes/config
#cd $TOMCAT_DIR$WEB_ROOT/WEB-INF/classes/spring
#/bin/cp -rf spring-rabbit.xml.web spring-rabbit.xml

#echo "====== Code has been deployed ======"
sleep 1
action "The new code deployment ......" /bin/true

# Start web server
echo " "
sleep 1
echo "====== Start the web server ======"
$TOMCAT_DIR/bin/catalina.sh start
ps -ef | grep "$TOMCAT_DIR" | grep -v grep
sleep 1
action "Start the web server ......" /bin/true

# Open web logs
#echo " "
#sleep 1
#echo "====== Open web server logs ======"
#tail -f $TOMCAT_DIR/logs/catalina.out
######################### END ###########################
