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
)

for IMAGE in "${IMAGES[@]}"; do
    # 提取镜像名称和 Tag
    REPOSITORY="${IMAGE%%:*}"
    TAG="${IMAGE##*:}"

    # 提取最后一级镜像名
    IMAGE_NAME="${REPOSITORY##*/}"

    # 阿里云镜像地址
    ALIYUN_IMAGE="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

    echo "=========================================="
    echo "本地镜像：${IMAGE}"
    echo "目标镜像：${ALIYUN_IMAGE}"
    echo "=========================================="

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
    echo
done

echo "=========================================="
echo "🎉 所有镜像 Push 完成"
echo "=========================================="
