# Smoke — API health

**Source:** `src/test/resources/features/smoke/health.feature`  
**Tags:** `@smoke` `@api`  
**Purpose:** Fast gate that TestFlow’s core API is up — same checks as Reqnroll `HealthApi.feature` and Playwright smoke API steps.

## Prerequisites

- TestFlow on `http://localhost:5050`
- `mvn test -Psmoke`

## Scenarios

| ID | Scenario | Asserts |
|----|----------|---------|
| TC-0020 | Health endpoint returns OK | `GET /health` → 200, under `healthTimeoutMs` |
| TC-0021 | Login returns a token | `POST /api/auth/login` → token (+ optional user email) |
| TC-0022 | Users list non-empty | `GET /api/users` → `users` array length > 0 |
| TC-0023 / TC-0024 | Error endpoints | `GET /api/errors/404` → 404; `/422` → 422 |

## Karate concepts used

- `Background` + `url baseUrl` from `karate-config.js`
- `responseTime` SLA asserts
- `Scenario Outline` for error codes
- Optional email check via `karate.get('response.user.email')` + `#?` predicate when login returns a `user` object
