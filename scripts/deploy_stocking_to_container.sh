#!/usr/bin/env bash
# Install this standalone feature without touching other plugins or user data.
set -euo pipefail
container_name="${1:-comfyui-test-cu130-megapak-pt211}"
repo_root="$(cd "$(dirname "$0")/.." && pwd)"
plugin_root="/root/ComfyUI/custom_nodes/ComfyUI-StockingTexture"
docker exec "$container_name" mkdir -p "$plugin_root"
tar --exclude=.git --exclude=__pycache__ --exclude=.pytest_cache --exclude=.venv --exclude=data -C "$repo_root" -cf - . | docker exec -i "$container_name" tar -xf - -C "$plugin_root"
docker restart "$container_name"
