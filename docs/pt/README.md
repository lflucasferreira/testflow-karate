# testflow-karate — Documentação em português

Guias espelham cada feature em `src/test/resources/features/`.

| Suite | Feature | Guia |
|-------|---------|------|
| Smoke | `smoke/health.feature` | [tests/smoke/health.md](tests/smoke/health.md) |
| Auth API | `api/auth.feature` | [tests/api/auth.md](tests/api/auth.md) |
| Users API | `api/users.feature` | [tests/api/users.md](tests/api/users.md) |
| Rules API | `api/rules.feature` | [tests/api/rules.md](tests/api/rules.md) |

## Como rodar uma suite

```bash
mvn test -Psmoke
mvn test -Dtest=ApiRunner
```
