Feature: API — Users & Health
  Users list contract, health, error simulation, and fixture checks — mirror of Playwright/Cypress API users suite.

  Background:
    * url baseUrl

  @api @regression @smoke
  Scenario: [TC-0022] GET /api/users returns 200 with schema-valid list
    Given path usersPath
    When method GET
    Then status 200
    * def elapsed = responseTime
    * assert elapsed < timeoutMs
    And match response.users == '#[]?'
    And match response.users == '#[_ > 0]'
    And match each response.users contains { name: '#string', email: '#string', role: '#string' }
    * match each response.users[*].email contains '@'

  @api @regression
  Scenario: User roles match golden fixture snapshot
    Given path usersPath
    When method GET
    Then status 200
    * def golden = read('classpath:fixtures/users/golden-roles.json')
    * def roles = karate.sort(karate.distinct(response.users.map(x => x.role)))
    * def expected = karate.sort(golden.roles)
    * match roles == expected

  @api @regression @smoke
  Scenario: [TC-0020] GET /health returns 200 within SLA
    Given path healthPath
    When method GET
    Then status 200
    * def elapsed = responseTime
    * assert elapsed < healthTimeoutMs

  @api @regression @smoke
  Scenario Outline: Error simulation endpoints
    Given path '<path>'
    When method GET
    Then status <status>
    * def errText = response.message || (response.error && response.error.message)
    * match errText == '#string'
    * assert errText.length > 0

    Examples:
      | path           | status |
      | api/errors/404 | 404    |
      | api/errors/422 | 422    |

  @api @regression
  Scenario: Countries lookup fixture has code and name keys
    * def data = read('classpath:fixtures/lookups/countries.json')
    * match data.countries == '#[_ > 0]'
    * match each data.countries contains { code: '#string', name: '#string' }
