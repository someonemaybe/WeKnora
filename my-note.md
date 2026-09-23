# 修改app镜像
./scripts/build_images.sh --app
docker compose up -d --force-recreate app

# 修改frontend镜像
docker compose build frontend
docker compose up -d frontend

# 将某用户设置为管理员，修改.env文件
WEKNORA_BOOTSTRAP_SYSTEM_ADMIN_EMAIL=yanjc163@163.com
# 修改后
docker compose up -d --force-recreate app

