# API — Users & Health

**Fonte:** `src/test/resources/features/api/users.feature`  
**Tags:** `@api` `@regression`  
**Objetivo:** Contrato da lista de users, fixture de roles, SLA do health, corpos de erro e fixture de países.

## Asserts principais

- Cada user tem `name`, `email`, `role` (strings)
- Roles distintas batem com `fixtures/users/golden-roles.json`
- Endpoints de erro expõem mensagem não vazia
