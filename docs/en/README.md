# testflow-karate — English docs

Walkthroughs mirror each feature file under `src/test/resources/features/`.

| Suite | Feature | Walkthrough |
|-------|---------|-------------|
| Smoke | `smoke/health.feature` | [tests/smoke/health.md](tests/smoke/health.md) |
| Auth API | `api/auth.feature` | [tests/api/auth.md](tests/api/auth.md) |
| Users API | `api/users.feature` | [tests/api/users.md](tests/api/users.md) |
| Rules API | `api/rules.feature` | [tests/api/rules.md](tests/api/rules.md) |

## How to run a single suite

```bash
mvn test -Psmoke
mvn test -Dtest=ApiRunner
```
