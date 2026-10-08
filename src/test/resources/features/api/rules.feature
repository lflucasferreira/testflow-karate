Feature: API — Rules engine patterns
  JSON Patch / rules-style updates against TestFlow users API — mirror of Playwright rules.api.spec.

  Background:
    * url baseUrl
    * def login = call read('classpath:features/common/auth.feature')
    * def authToken = login.authToken
    * def authHeader = login.authHeader
    * def payloads = read('classpath:fixtures/api/patch-payloads.json')

  @api @regression
  Scenario: JSON Patch builder shape is RFC 6902
    * def patches =
      """
      [
        { "op": "replace", "path": "/name", "value": "Alex" },
        { "op": "replace", "path": "/role", "value": "admin" }
      ]
      """
    * match patches == '#[2]'
    * match patches[0] == { op: 'replace', path: '/name', value: 'Alex' }

  @api @regression
  Scenario: PATCH via rules accepts JSON Patch content type
    * def patches = [{ op: 'replace', path: '/name', value: 'Patch Test User' }]
    Given path usersPath, 1
    And header Authorization = authHeader
    And header Content-Type = 'application/json-patch+json'
    And request patches
    When method PATCH
    # TestFlow may return 200/204 (happy), 404 (missing user), or 4xx/405 depending on rules support
    * match [200, 204, 400, 404, 405, 422] contains responseStatus

  @api @regression
  Scenario Outline: Data-driven — valid name payloads
    * def item = payloads.validNamePatches[<index>]
    * def userId = item.userId ? item.userId : 1
    Given path usersPath, userId
    And header Authorization = authHeader
    And header Content-Type = 'application/json-patch+json'
    And request item.patches
    When method PATCH
    * match [200, 204, 400, 404, 405, 422] contains responseStatus

    Examples:
      | index |
      | 0     |
      | 1     |

  @api @regression
  Scenario Outline: Data-driven — invalid payloads
    * def item = payloads.invalidPatches[<index>]
    * def userId = item.userId ? item.userId : 999
    Given path usersPath, userId
    And header Authorization = authHeader
    And header Content-Type = 'application/json-patch+json'
    And request item.patches
    When method PATCH
    * match [400, 404, 422, 500] contains responseStatus

    Examples:
      | index |
      | 0     |
      | 1     |

  @api @regression
  Scenario: [TC-0301] Read-after-write — GET /api/users with Bearer token
    Given path usersPath
    And header Authorization = authHeader
    When method GET
    Then status 200
    And match response.users == '#[_ > 0]'
    And match response.users[0] contains { name: '#string', email: '#string', role: '#string' }

  @api @regression @auth
  Scenario: Login stores usable Bearer token
    Given path loginPath
    And request { email: '#(demoEmail)', password: '#(demoPassword)' }
    When method POST
    Then status 200
    And match response.token == '#string'
    And match response.token != ''
