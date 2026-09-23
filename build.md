# 修改app镜像
./scripts/build_images.sh --app
docker compose up -d --force-recreate app

# 修改frontend镜像
docker compose build frontend
docker compose up -d frontend
