# API — Auth login

**Source:** `src/test/resources/features/api/auth.feature`  
**Tags:** `@auth` `@api` `@regression`  
**Purpose:** Full contract for `POST /api/auth/login` — port of Playwright `auth.api.spec.ts` / Capybara `auth_api_spec.rb` (API parts only).

## Scenarios

1. **Valid credentials** — 200, JSON content-type, SLA, schema, optional user email, token reused on `GET /api/users`
2. **Wrong password / unknown email** — 401
3. **Error body** — non-empty `message` or `error.message`
4. **Malformed body** — empty / missing email / missing password → 400–422
