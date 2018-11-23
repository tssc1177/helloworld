## 脚本注释
本目录下几个脚本为手动发布基于Java开发，且运行于tomcat的项目，需要使用*.war格式的Java代码包，可以实现更新，启动，停止，重启，查看tomcat日志等基本操作

脚本可以存放于任意目录，这里推荐以下目录：
```
mkdir -p /server/uptate_tomcat1_web
```

### update_tomcat1_v20170509.sh 为更新代码的脚本
- 变量“TOMCAT_DIR”定义tomcat目录，这里指向“/usr/local/tomcat1”
- 变量“WEB_ROOT”定义tomcat的项目目录，如果没有手动指定tomcat的项目目录，需要修改为“/webapps/ROOT”
- 脚本运行方法：./update_tomcat1_v20170509.sh *.war 
- 实例：./update_tomcat1_v20170509.sh web.war 
- 脚本执行流程：
1. 停止tomcat服务，将项目代码备份到脚本所在目录并创建以时间命名的目录
1. 清理日志及缓存文件
1. 重新创建项目目录，解压war包到项目目录
1. 启动tomcat
1. 使用tail动态查看启动日志，检查是否报错


### start_tomcat1_v20160214.sh
- 可以手动启动tomcat1中的项目，启动时会清空

### stop_tomcat1_v20160214.sh
- 单纯的停掉tomcat

### open_tomcat1_log_v20160222.sh志
- 使用tail动态查看catalina.out日志

### restart_tomcat1_20160214.sh
- 区别于直接启动tomcat的脚本，该脚本在启动时会将之前的catalina.out日志保存到/tmp目录下，便于查找定位问题
