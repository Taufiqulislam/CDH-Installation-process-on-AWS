#!/bin/bash
#With this commend it gonna extened the root or /dev/xvde on all the hosts on servers.txt
for i in $(cat servers.txt); do echo $i; ssh -t $i 'df -h; sudo resize2fs /dev/xvde; df -h'; done;