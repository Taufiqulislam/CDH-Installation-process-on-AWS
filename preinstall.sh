#!/bin/bash
#update yum
sudo yum update
#Check NTPD is running or not
for i in $(cat servers.txt); do echo $i; ssh -t $i 'sudo service ntpd status;sudo  date;sudo  ntpq -p'; done;
for i in $(cat servers.txt); do echo $i; ssh -t $i 'sudo service ntpd start'; done;
#Check IPTALES status and stop
for i in $(cat servers.txt); do echo $i; ssh -t $i 'sudo chkconfig iptables off; sudo /etc/init.d/iptables stop'; done;
#Check SELINUX
for i in $(cat servers.txt); do echo $i; ssh -t $i 'sudo echo 0 >/selinux/enforce'; done;
for i in $(cat servers.txt); do echo $i; ssh -t $i ' cat /etc/sysconfig/selinux |grep SELINUX'; done;
#Check for ulimit(value should me more that 10000)
for i in $(cat servers.txt); do echo $i; ssh -t $i 'sudo ulimit -Sn;sudo  ulimit -Hn'; done;
#Check Umask (it should be 0022)
for i in $(cat servers.txt); do echo $i; ssh -t $i 'sudo umask '; done;
#check hostnames
hostname
hostname -f
#mysql install
sudo yum install mysql-server
#stop mysql
sudo service mysqld stop
#Ensure the MySQL server starts at boot.
sudo /sbin/chkconfig mysqld on
sudo /sbin/chkconfig --list mysqld
sudo service mysqld start
#Set the MySQL root password. In the following example, the current root password is blank. Press the Enter key when you're prompted for the root paswd.
sudo /usr/bin/mysql_secure_installation
#Installing the MySQL JDBC Driver
cd ~
tar zxvf mysql-connector-java-5.1.39.tar.gz
sudo scp mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar /usr/share/java/mysql-connector-java.jar
sudo mkdir -p /usr/share/java/
sudo scp mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar /usr/share/java/mysql-connector-java.jar
ls -ltr /usr/share/java/mysql-connector-java.jar