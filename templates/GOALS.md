# 项目目标清单
> 唯一进度真相源。每次会话开始必读,每次沉淀/回滚必更新。

## 状态说明: ✅ 已沉淀到 main | 🔧 进行中 | ⬜ 未开始 | 🔄 已回滚待重试

## 模块目标
### [G-01] 模块名: user_auth
- 描述: 用户注册与登录
- 契约: CONTRACTS.md#user_auth
- 验收标准: 正确密码返回 token;错误密码返回 401;空输入返回 400
- 测试: tests/unit/test_auth.py
- 状态: ⬜
- 沉淀记录: (commit hash / 日期)

## 拼装目标
### [A-01] 登录完整流程 (依赖: G-01, G-02, G-03)
- 验收标准: 用户从 UI 输入到登录成功全流程可用
- 测试: tests/integration/test_login_flow.py
- 状态: ⬜
