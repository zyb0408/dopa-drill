#!/usr/bin/env bash
# 启动 Dopa Drill 静态站点（ES Modules，无需构建）
# 用法: ./start.sh            # 默认端口 4175
#       PORT=8080 ./start.sh  # 自定义端口
set -euo pipefail

PORT="${PORT:-4175}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="${SCRIPT_DIR}/app"

# 优先使用托管的 Python（保证 .js MIME 正确），否则回退到系统 python3
if [ -x "/Users/yingbin/.workbuddy/binaries/python/versions/3.13.12/bin/python3" ]; then
  PYTHON="/Users/yingbin/.workbuddy/binaries/python/versions/3.13.12/bin/python3"
elif command -v python3 >/dev/null 2>&1; then
  PYTHON="$(command -v python3)"
else
  echo "未找到 python3，无法启动静态服务器" >&2
  exit 1
fi

echo "Dopa Drill 启动中 → http://localhost:${PORT}/"
echo "根目录: ${ROOT}"
exec "$PYTHON" -m http.server "${PORT}" -d "${ROOT}"
