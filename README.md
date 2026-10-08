# testflow-karate

[Karate](https://www.karatelabs.io/) API automation suite for [TestFlow](https://github.com/qaschoolbr/testflow) — Java/BDD mirror of the Cypress (`testflow-cypress`) and Playwright (`testflow-playwright`) suites, focused on the REST contracts those projects cover under `api/` and smoke health checks.

## Stack

| Tool | Purpose |
|------|---------|
| Java 17+ | Language / runtime |
| Maven 3.9+ | Build & test runner |
| Karate 1.5 | API DSL (Gherkin) + assertions + reports |
| JUnit 5 | Runner bridge (`karate-junit5`) |

## Test coverage

| Suite | Feature | Tags | What it covers |
|-------|---------|------|----------------|
| `smoke` | `features/smoke/health.feature` | `@smoke` `@api` | `/health`, login token, `/api/users`, error 404/422 |
| `auth` | `features/api/auth.feature` | `@auth` `@api` `@regression` | Login contract, 401s, malformed body, token reuse |
| `api` | `features/api/users.feature` | `@api` `@regression` | Users schema, golden roles, health SLA, error bodies, fixtures |
| `api` | `features/api/rules.feature` | `@api` `@regression` | JSON Patch shape, PATCH users, data-driven payloads, Bearer read |

Traceable case IDs use the `[TC-xxxx]` prefix (same numbering as Cypress/Playwright).

UI suites (dashboard, team, wizard, a11y, visual, …) stay in the Cypress/Playwright/Robot siblings — Karate here owns the API layer. Karate UI (`driver`) can be added later if needed.

## Prerequisites

- Java 17+ (Java 21/25/26 also fine)
- Maven 3.9+
- TestFlow running on port `5050`

## Setup

```bash
mvn -q -DskipTests dependency:resolve
```

### Maven Central 403 (Cloudflare)

If dependency download fails with `403 Forbidden` from `repo.maven.apache.org`, use the Google mirror settings bundled in the repo:

```bash
mvn -s scripts/maven-settings-mirror.xml test
```

### Credentials

| Field | Value |
|-------|-------|
| Email | `demo@automation.io` |
| Password | `Demo123!` |

Override via environment variables:

```bash
export DEMO_EMAIL=demo@automation.io
export DEMO_PASSWORD=your-secret
export BASE_URL=http://localhost:5050
```

See `.env.example` for all supported variables.

## Running the app

```bash
docker run --rm -p 5050:5050 qaschool/testflow:latest
```

Or clone and start TestFlow from source — see the [TestFlow repo](https://github.com/qaschoolbr/testflow).

## Running tests

```bash
# Full suite
mvn test

# By Maven profile (tags)
mvn test -Psmoke
mvn test -Papi
mvn test -Pregression
mvn test -Pauth

# Or pass tags directly
mvn test -Dkarate.options="--tags @smoke"
mvn test -Dkarate.options="--tags @api"

# Dedicated suite runners
mvn test -Dtest=SmokeRunner
mvn test -Dtest=ApiRunner
mvn test -Dtest=AuthRunner

# CI-style env
mvn test -Pci
```

HTML reports land under `target/karate-reports/` after each run.

## Project structure

```
testflow-karate/
├── src/test/java/io/testflow/karate/runners/
│   ├── AllRunner.java       # default Surefire entry (full / tagged)
│   ├── SmokeRunner.java     # @smoke only
│   ├── ApiRunner.java       # @api only
│   └── AuthRunner.java      # @auth only
├── src/test/resources/
│   ├── karate-config.js     # baseUrl, credentials, timeouts (local/ci/staging)
│   ├── features/
│   │   ├── common/auth.feature   # reusable login helper (@ignore)
│   │   ├── smoke/health.feature
│   │   └── api/{auth,users,rules}.feature
│   └── fixtures/            # credentials, schemas, golden roles, patch payloads
├── docs/                    # bilingual walkthroughs (EN + PT)
├── .github/workflows/karate.yml
└── pom.xml
```

## Environments

| `karate.env` / `KARATE_ENV` | Base URL |
|-----------------------------|----------|
| `local` (default) | `http://localhost:5050` |
| `ci` | `http://localhost:5050` |
| `staging` | requires `STAGING_URL` |

`BASE_URL` always wins when set.

## CI

GitHub Actions (`.github/workflows/karate.yml`) on push/PR to `main`:

| Job | What it runs |
|-----|----------------|
| `smoke` | `@smoke` gate against `qaschool/testflow:latest` |
| `api` | Full `@api` / regression suite |
| `report` | Uploads `target/karate-reports/` as artifact |

## Docs

- Language picker: [`docs/README.md`](docs/README.md)
- English walkthroughs: `docs/en/`
- Portuguese walkthroughs: `docs/pt/`

## Parity with Cypress / Playwright

| Concern | This repo |
|---------|-----------|
| Base URL | `http://localhost:5050` |
| Demo user | `demo@automation.io` / `Demo123!` |
| Tags | `@smoke`, `@api`, `@regression`, `@auth` |
| TC IDs | `[TC-0020]` … `[TC-0301]` (shared numbering) |
| Fixtures | Same shapes under `fixtures/` |
| SUT | `qaschool/testflow:latest` |

## Technologies

- [Karate](https://github.com/karatelabs/karate)
- [JUnit 5](https://junit.org/junit5/)
- Maven

## License

Same as TestFlow / parent automation projects.
