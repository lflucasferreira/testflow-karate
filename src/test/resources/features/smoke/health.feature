Feature: Smoke — API health
  Quick checks that the core API is reachable and responding correctly.

  Background:
    * url baseUrl

  @smoke @api
  Scenario: [TC-0020] Health endpoint returns OK
    Given path healthPath
    When method GET
    Then status 200
    * def elapsed = responseTime
    * assert elapsed < healthTimeoutMs

  @smoke @api @auth
  Scenario: [TC-0021] Login returns a token
    Given path loginPath
    And request { email: '#(demoEmail)', password: '#(demoPassword)' }
    When method POST
    Then status 200
    And match response == read('classpath:fixtures/schemas/auth-login.json')
    And match response.token != ''
    * def userEmail = karate.get('response.user.email')
    * match userEmail == '#? _ == null || _ == "' + demoEmail + '"'

  @smoke @api
  Scenario: [TC-0022] Users endpoint returns a non-empty array
    Given path usersPath
    When method GET
    Then status 200
    And match response.users == '#[]'
    And match response.users == '#[_ > 0]'

  @smoke @api
  Scenario Outline: [TC-0023/TC-0024] Error endpoints return the expected status
    Given path '<path>'
    When method GET
    Then status <status>

    Examples:
      | path            | status |
      | api/errors/404  | 404    |
      | api/errors/422  | 422    |
