#!/bin/bash
WORK_PATH='/usr/poject/object-web'
cd $WORK_PATH
echo "清理web代码"
git reset --hard origin/master
git clean -f
echo "拉取web最新代码"
git pull origin master

echo "编译"
npm run build

echo "开始构建镜像"
docker build -t object-web:1.0 .
echo "删除旧容器"
docker stop object-web-container
docker rm object-web-container
echo "启动新容器"
docker container run -p 80:80 -d --name object-web-container -d object-web:1.0