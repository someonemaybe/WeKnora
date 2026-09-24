#!/bin/bash

REGISTRY="registry.cn-hangzhou.aliyuncs.com"
NAMESPACE="yjcai"

IMAGES=(
    "hiai/hiai-app:latest"
    "hiai/hiai-docreader:latest"
    "hiai/hiai-sandbox:latest"
    "hiai/hiai-sandbox:latest-cube"
    "hiai/hiai-sandbox:latest-desktop"
    "hiai/hiai-sandbox:latest-desktop-cube"
    "hiai/hiai-sandbox:main"
    "hiai/hiai-sandbox:main-cube"
    "hiai/hiai-sandbox:main-desktop"
    "hiai/hiai-sandbox:main-desktop-cube"
    "hiai/hiai-ui:latest"

    # 新增镜像
    "paradedb/paradedb:v0.22.6-pg17"
    "redis:7.0-alpine"
)

for IMAGE in "${IMAGES[@]}"; do

    # 提取 Repository
    REPOSITORY="${IMAGE%%:*}"

    # 提取 Tag
    TAG="${IMAGE##*:}"

    # 取 Repository 最后一段作为阿里云仓库名称
    IMAGE_NAME="${REPOSITORY##*/}"

    # 拼接阿里云完整镜像地址
    ALIYUN_IMAGE="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

    echo
    echo "=========================================="
    echo "本地镜像：${IMAGE}"
    echo "阿里云镜像：${ALIYUN_IMAGE}"
    echo "=========================================="

    # 检查本地镜像是否存在
    if ! docker image inspect "${IMAGE}" >/dev/null 2>&1; then
        echo "❌ 本地镜像不存在：${IMAGE}"
        exit 1
    fi

    echo "[1/2] Docker Tag..."
    docker tag "${IMAGE}" "${ALIYUN_IMAGE}"

    if [ $? -ne 0 ]; then
        echo "❌ Tag 失败：${IMAGE}"
        exit 1
    fi

    echo "[2/2] Docker Push..."
    docker push "${ALIYUN_IMAGE}"

    if [ $? -ne 0 ]; then
        echo "❌ Push 失败：${ALIYUN_IMAGE}"
        exit 1
    fi

    echo "✅ Push 成功：${ALIYUN_IMAGE}"
done

echo
echo "=========================================="
echo "🎉 所有镜像 Push 完成"
echo "=========================================="
