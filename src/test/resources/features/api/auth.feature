Feature: API — POST /api/auth/login
  Contract coverage for TestFlow authentication — mirror of testflow-playwright/cypress auth API specs.

  Background:
    * url baseUrl
    * path loginPath
    * def valid = { email: '#(demoEmail)', password: '#(demoPassword)' }

  @api @regression @auth @smoke
  Scenario: [TC-0101] Valid credentials return 200 with token
    Given request valid
    When method POST
    Then status 200
    And match header Content-Type contains 'application/json'
    * def elapsed = responseTime
    * assert elapsed < timeoutMs
    And match response == read('classpath:fixtures/schemas/auth-login.json')
    And match response.token != ''
    # When login returns a user object, email must match the demo account
    * def userEmail = karate.get('response.user.email')
    * match userEmail == '#? _ == null || _ == "' + demoEmail + '"'
    * def token = response.token

    # Token authenticates a subsequent request
    Given url baseUrl
    And path usersPath
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200

  @api @regression @auth
  Scenario: [TC-0103] Wrong password returns 401
    Given request { email: '#(demoEmail)', password: 'wrongpassword' }
    When method POST
    Then status 401

  @api @regression @auth
  Scenario: Unknown email returns 401
    Given request { email: 'nobody@example.com', password: '#(demoPassword)' }
    When method POST
    Then status 401

  @api @regression @auth
  Scenario: Error body has a non-empty message or error field
    Given request { email: '#(demoEmail)', password: 'wrong' }
    When method POST
    Then status 401
    * def errText = response.message || (response.error && response.error.message)
    * match errText == '#string'
    * assert errText.length > 0

  @api @regression @auth
  Scenario Outline: Malformed login body returns 4xx
    Given request <body>
    When method POST
    * assert responseStatus >= 400 && responseStatus <= 422

    Examples:
      | body                              |
      | {}                                |
      | { password: '#(demoPassword)' }   |
      | { email: '#(demoEmail)' }         |
