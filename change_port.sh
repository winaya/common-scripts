#!/bin/bash
# 一键更改nginx https端口
fileName=/etc/nginx/conf/conf.d/v2ray.conf
qrFile=/usr/local/vmess_qr.json
echo 开始修改nginx的https配置端口
echo 配置文件路径为: $fileName
oldPort=`cat $fileName |grep listen|head -n 1|tail -n 1| awk '{print $2}'`
newPort=`expr $oldPort + 1`
echo 原https端口为: $oldPort
read -p 请输入新端口[$newPort]: inputPort
if [ -z $inputPort ];then
inputPort=$newPort
fi
sed -i "1,4s/${oldPort}/${inputPort}/" $fileName
sed -i "1,6s/${oldPort}/${inputPort}/" $qrFile
# nginx -s reload
systemctl restart nginx
echo 修改完成，新端口为: $inputPort
