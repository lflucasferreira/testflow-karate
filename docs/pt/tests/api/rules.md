# API — Rules / JSON Patch

**Fonte:** `src/test/resources/features/api/rules.feature`  
**Tags:** `@api` `@regression`  
**Objetivo:** Padrões de PATCH estilo rules engine — porte do Playwright `rules.api.spec.ts`.

## Fluxo

1. `call` do `common/auth.feature` → token Bearer
2. Assert do shape RFC 6902
3. `PATCH /api/users/{id}` com `application/json-patch+json`
4. Payloads data-driven (válidos / inválidos) de `fixtures/api/patch-payloads.json`
5. `GET /api/users` autenticado (read-after-write)

Os status aceitos seguem a tolerância do Playwright (o TestFlow pode ainda não implementar JSON Patch completo).
