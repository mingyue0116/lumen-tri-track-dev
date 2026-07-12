#!/usr/bin/env bash
# 用法: bash scripts/rollback.sh
# 作用: 将 dev 强制重置到 staging,丢弃试验田上的失败修改
set -euo pipefail

git checkout dev
echo "==> 即将丢弃以下修改:"
git log --oneline staging..dev || true
git status --short

read -p "确认回滚 dev 到 staging? [y/N] " ans
[[ "$ans" == "y" ]] || { echo "已取消"; exit 0; }

git reset --hard staging
git clean -fd
echo "✅ dev 已重置到 staging,可以换思路重新开始"
