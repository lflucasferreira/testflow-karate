# API — Auth login

**Fonte:** `src/test/resources/features/api/auth.feature`  
**Tags:** `@auth` `@api` `@regression`  
**Objetivo:** Contrato completo de `POST /api/auth/login` — porte do Playwright `auth.api.spec.ts` / Capybara `auth_api_spec.rb` (só a parte API).

## Cenários

1. **Credenciais válidas** — 200, content-type JSON, SLA, schema, email opcional, token reutilizado em `GET /api/users`
2. **Senha errada / email desconhecido** — 401
3. **Corpo de erro** — `message` ou `error.message` não vazio
4. **Body malformado** — vazio / sem email / sem senha → 400–422
