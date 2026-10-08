# API — Rules / JSON Patch

**Source:** `src/test/resources/features/api/rules.feature`  
**Tags:** `@api` `@regression`  
**Purpose:** Rules-engine style PATCH patterns — port of Playwright `rules.api.spec.ts`.

## Flow

1. `call` shared `common/auth.feature` → Bearer token
2. Assert RFC 6902 patch document shape
3. `PATCH /api/users/{id}` with `application/json-patch+json`
4. Data-driven valid / invalid payloads from `fixtures/api/patch-payloads.json`
5. Authenticated `GET /api/users` read-after-write

Allowed statuses mirror Playwright’s tolerant expectations (TestFlow may not implement full JSON Patch yet).
