# API — Users & Health

**Source:** `src/test/resources/features/api/users.feature`  
**Tags:** `@api` `@regression`  
**Purpose:** Users list contract, golden roles fixture, health SLA, error bodies, countries lookup fixture.

## Key asserts

- Each user has `name`, `email`, `role` (strings)
- Distinct roles match `fixtures/users/golden-roles.json`
- Error endpoints expose a non-empty message field
