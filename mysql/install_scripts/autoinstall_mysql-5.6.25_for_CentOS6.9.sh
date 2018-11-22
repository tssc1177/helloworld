#!/bin/sh
######################################################
# Author: ZhaoShuai
# Date: 20160307
# System: CentOS6.9-x86_64
# Made for autoinstall mysql-5.6.25 by source package
######################################################
# 0.尽量提前配置好主机名和hosts域名解析

# 1.安装cmake编译工具和mysql依赖包
yum install gcc gcc-c++ cmake ncurses-devel -y

# 2.创建运行用户和组
groupadd mysql
useradd mysql -s /sbin/nologin -M -g mysql

# 3.安装mysql
# 下载mysql安装包
mkdir -p /server/tools/
cd /server/tools/
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.25.tar.gz

# 配置,编译安装
tar -zxf mysql-5.6.25.tar.gz
cd /server/tools/mysql-5.6.25/

cmake \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_DATADIR=/usr/local/mysql/data \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DEXTRA_CHARSETS=all \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITHOUT_EXAMPLE_STORAGE_ENGINE=1 \
-DWITH_FAST_MUTEXES=1 \
-DWITH_ZLIB=bundled \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_EMBEDDED_SERVER=1 \
-DWITH_DEBUG=0 \
-DWITH_READLINE=1 \
-DENABLE_DOWNLOADS=1

sleep 2
make 
make install

# 4.完成后的配置优化
# 创建mysql数据文件目录
mkdir -p /usr/local/mysql/data/
mkdir -p /usr/local/mysql/logs

# 配置环境变量
export PATH=/usr/local/mysql/bin:$PATH
echo 'export PATH=/usr/local/mysql/bin:$PATH' >> /etc/profile
echo $PATH

# 5.进行个性化配置
mv /etc/my.cnf /etc/my.cnf.old
cp support-files/my-default.cnf /etc/my.cnf

# 授权mysql用户访问mysql的安装目录
chown -R mysql.mysql /usr/local/mysql
ll /usr/local/mysql/

# 调整/tmp目录的权限，防止初始化错误
chmod 1777 /tmp
ll /tmp -d

# 初始化数据库，创建数据表，初始化之前注意要在hosts文件配置主机名解析，消除警告信息
# vim /etc/hosts

cd /usr/local/mysql/scripts/
./mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data/ --user=mysql 
sleep 1

# 配置启动脚本文件
cd /usr/local/mysql
cp support-files/mysql.server  /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld 

# 配置开机启动mysql
chkconfig --add mysqld 
chkconfig mysqld on
chkconfig --list mysqld

# 启动mysql数据库
/etc/init.d/mysqld start
netstat -anptl |grep mysql
# tail -f  /usr/local/mysql/logs/mysqld.log 

echo "====== Install mysql is OK! ======"
################### End #####################
