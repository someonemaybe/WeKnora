### 修改app镜像
./scripts/build_images.sh --app
docker compose up -d --force-recreate app

### 修改frontend镜像
docker compose build frontend
docker compose up -d frontend

### 将某用户设置为管理员，修改.env文件
WEKNORA_BOOTSTRAP_SYSTEM_ADMIN_EMAIL=yanjc163@163.com
##### 修改后
docker compose up -d --force-recreate app


### 打开docker沙箱报错：无法连接 Docker 守护进程：failed to connect to the docker API at unix:///var/run/docker.sock; check if the path is correct and if the daemon is running: dial unix /var/run/docker.sock: connect: no such file or directory
#### 原因：
HiAI-app 容器里没有 Docker 套接字。当前 compose 里 /var/run/docker.sock 的挂载是注释掉的。只开「启用 Docker 沙箱」不够，还要在 docker-compose.yml 的 app 服务里取消这行注释，并重启 app：
- /var/run/docker.sock:/var/run/docker.sock
本机还要先有这个镜像（docker images 里能看到 hiai/hiai-sandbox:main 或 :latest）。没有的话先构建：
./scripts/build_images.sh --sandbox
镜像名保持 hiai/hiai-sandbox:main 即可，不必改回 wechatopenai/weknora-sandbox。
