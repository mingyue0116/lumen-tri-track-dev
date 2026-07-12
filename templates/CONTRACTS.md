# 接口契约
> 唯一接口真相源。变更必须先改本文档,再改代码。

## user_auth
### login(username: str, password: str) -> AuthResult
- 输入: username 非空字符串; password 非空字符串
- 输出: 成功 → { token: str, expires_at: ISO8601 字符串 }
- 错误: 密码错误 → AuthError(code=401); 输入为空 → ValidationError(code=400)
- 边界: username 前后空格自动去除; 连续失败 5 次锁定 10 分钟
