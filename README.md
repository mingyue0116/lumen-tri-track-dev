# Lumen Tri-Track Dev（三轨稳定开发法）

> **正确的代码只进不退，错误的修改随时可回滚，项目目标永不丢失。**

**Lumen Tri-Track Dev**（三轨稳定开发法）是一套面向 AI 编程的工程化管理方法论。
它通过 **main / staging / dev 三分支棘轮机制**，为 AI 辅助开发提供了可落地的质量保障体系。

---

## 项目简介

在 AI 编程时代，代码生成速度快了，但质量把控更难了。

传统的 Git 分支模型和 Code Review 流程，对 AI 生成代码的约束力不够——
AI 可能一次改多件事、改崩了继续在错误代码上修修补补、或者在 main 分支上直接写代码。

**三轨开发法** 就是为了解决这个问题而生的：

- 防御体系：用脚本和 Git hook 建立硬防线，禁止在 main/staging 上直接写代码
- 自动化沉淀：promote.sh 一键将通过测试的 commit 从 dev cherry-pick 到 main
- 安全回滚：rollback.sh 一键将 dev 重置到 staging，及时止损
- 契约先行：先定义接口契约再写代码，模块间不匹配时停下来汇报
- 测试驱动：每个目标先写测试再实现，测试通过才能进入沉淀流程
- 进度可视：GOALS.md 追踪每个目标的完成状态和沉淀记录
- 自审查清单：内置六大维度的代码审查项 + 历史 Bug 经验沉淀

---

## 三分支模型

| 分支 | 角色 | 规则 |
|------|------|------|
| main | 稳定版（棘轮） | 禁止直接编写或修改任何代码。只接受通过全部测试的 cherry-pick |
| staging | 兜底快照 | 上一个"确认能跑"的状态。只通过脚本同步，禁止手动修改 |
| dev | 试验田 | 所有开发工作只在这里进行。改崩了立即回滚到 staging |

---

## 使用方法

### 1. 初始化项目

`
git init
git checkout -b main
# 将本项目模板拷贝到你的项目中
git add -A && git commit -m "chore: init tri-track project"
git branch staging
git checkout -b dev
`

### 2. 定规则（收敛）

与团队成员/用户确认技术栈、UI 规范 > 写入 ARCHITECTURE.md
将功能拆解为模块 > 定义接口契约 > 写入 CONTRACTS.md
为每个模块建立目标条目（含验收标准）> 写入 GOALS.md

### 3. 开发（发散 > 沉淀）

`
选一个目标 > 先写测试 > dev 上实现 > 跑测试
  通过 > 执行代码自审查 > 通过则运行 promote.sh 沉淀到 main
  失败 > 运行 rollback.sh 回滚到 staging > 分析根因 > 重试
`

### 4. 拼装集成

相关模块全部完成后，写胶水代码组装，不改模块内部实现。

---

## 文件结构

`
lumen-tri-track-dev/
  SKILL.md                  # 核心 Skill 定义（完整流程）
  templates/
    ARCHITECTURE.md         # 技术栈/架构模板
    CONTRACTS.md            # 接口契约模板
    GOALS.md                # 目标追踪模板
  scripts/
    promote.sh              # 沉淀脚本（dev 到 main）
    rollback.sh             # 回滚脚本（dev 到 staging）
  .git/hooks/
    pre-commit              # 硬防线：禁止在 main/staging 上直接提交
`

---

## 适用场景

- AI 辅助开发：约束 AI 的行为边界，让 AI 生成更可靠的代码
- 团队协作：统一开发流程，降低沟通成本
- 需要严格质量保障的项目：测试先行 + 代码审查 + 历史 Bug 沉淀
- 快速迭代的产品：dev 上放开手脚试错，main 上永远稳定

---

## License

Copyright 2025 lumen.ai

本作品采用 **Creative Commons Attribution-NonCommercial 4.0 International（CC BY-NC 4.0）** 许可证。

你可以：
- 个人学习和研究使用
- 修改和分享（需注明出处）

你不可以：
- 用于商业目的
- 将本作品或其衍生品用于盈利

完整的许可证条款请查看 LICENSE 文件。

---

## 作者

- **lumen.ai** - 明月