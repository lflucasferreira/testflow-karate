# Smoke — API health

**Fonte:** `src/test/resources/features/smoke/health.feature`  
**Tags:** `@smoke` `@api`  
**Objetivo:** Gate rápido de que a API do TestFlow está no ar — mesmos checks do Reqnroll `HealthApi.feature` e do smoke API do Playwright.

## Pré-requisitos

- TestFlow em `http://localhost:5050`
- `mvn test -Psmoke`

## Cenários

| ID | Cenário | O que valida |
|----|---------|--------------|
| TC-0020 | Health endpoint returns OK | `GET /health` → 200, dentro de `healthTimeoutMs` |
| TC-0021 | Login returns a token | `POST /api/auth/login` → token (+ email do user, se vier) |
| TC-0022 | Users list non-empty | `GET /api/users` → array `users` com length > 0 |
| TC-0023 / TC-0024 | Error endpoints | `GET /api/errors/404` → 404; `/422` → 422 |

## Conceitos Karate usados

- `Background` + `url baseUrl` via `karate-config.js`
- Asserts de SLA com `responseTime`
- `Scenario Outline` para códigos de erro
- Check opcional de email via `karate.get('response.user.email')` + predicado `#?` quando o login devolve `user`
