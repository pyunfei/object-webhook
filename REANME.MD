# server.sh属于后端打包项目
 - 服务端项目相对于而言较为简单
 ``` DockerFile
    FROM node
    LABEL name="object-server"
    LABEL version="1.0"
    COPY . /app
    WORKDIR /app
    RUN npm install
    EXPOSE 3000
    CMD npm start
```

# web.sh属于前端打包项目
 - 构建镜像属于要先执行的命令, 需要先在服务器`contos`中执行脚本`sh xxx.sh`来构建镜像
 - `object-x:1.0`需要跟上版本号, 不然服务器构建`docker`会出呈现least无法构建
 - `web`项目中的`DockerFile`文件需要注意是使用`nginx`来代理, 提供一下我的实例， 另外前端项目较为复杂, 需要单独的创建某一个配置文件`web.conf`, 拷贝覆盖默认的`nginx`配置文件
``` DockerFile
    FROM nginx
    LABEL name="object-web"
    LABEL version="1.0"
    COPY ./dist /usr/share/nginx/html
    COPY ./web.conf /etc/nginx/conf.d
    EXPOSE 80
```
```conf
server {
    listen 80;
    server_name port;
    location :{
        root  /usr/share/nginx/html;
        index index.html index.htm
        try_files $uri $uri/ /index.html
    }
    location /api {
        proxy_pass port
    }
}
```