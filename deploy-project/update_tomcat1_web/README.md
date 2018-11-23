## 脚本注释
本目录下几个脚本为手动发布基于Java开发，且运行于tomcat的项目，需要使用*.war格式的Java代码包，可以实现更新，启动，停止，重启，查看tomcat日志等基本操作
脚本可以存放于任意目录，这里推荐以下目录：
mkdir -p /server/uptate_tomcat1_web

### update_tomcat1_v20170509.sh 为更新代码的脚本
其中“TOMCAT_DIR”变量定义tomcat目录，这里指向“/usr/local/tomcat1”，
“WEB_ROOT”变量定义tomcat的项目目录，如果没有手动指定tomcat的项目目录，需要修改为“/webapps/ROOT”
脚本运行方法：./update_tomcat1_v20170509.sh *.war 


### start_tomcat1_v20160214.sh 为手动启动tomcat的脚本

### stop_tomcat1_v20160214.sh 为手动停止tomcat的脚本

### open_tomcat1_log_v20160222.sh 脚本可以查看tomcat的catalina.out日志

