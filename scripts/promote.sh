#!/usr/bin/env bash
# 用法: bash scripts/promote.sh <commit-hash>
# 作用: 将 dev 上的指定 commit 沉淀到 main,并同步 staging
set -euo pipefail

COMMIT="${1:?用法: promote.sh <commit-hash>}"
TEST_CMD="${TEST_CMD:-bash scripts/run_tests.sh}"   # 按项目实际测试命令修改

echo "==> [1/5] 校验 commit 存在于 dev..."
git merge-base --is-ancestor "$COMMIT" dev || { echo "❌ 该 commit 不在 dev 上"; exit 1; }

echo "==> [2/5] 切换到 main 并 cherry-pick..."
git checkout main
if ! git cherry-pick "$COMMIT"; then
  echo "❌ cherry-pick 冲突,自动还原 main"
  git cherry-pick --abort
  git checkout dev
  exit 1
fi

echo "==> [3/5] 在 main 上运行全量测试..."
if ! $TEST_CMD; then
  echo "❌ main 上测试失败,回退本次 cherry-pick"
  git reset --hard HEAD~1
  git checkout dev
  exit 1
fi

echo "==> [4/5] 同步 staging 到当前 dev..."
git branch -f staging dev

echo "==> [5/5] 返回 dev"
git checkout dev
echo "✅ 沉淀成功: $COMMIT 已进入 main,staging 已更新"
echo "⚠️  别忘了更新 GOALS.md 中对应目标的状态"
