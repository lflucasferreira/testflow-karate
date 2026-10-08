@ignore
Feature: Shared auth helpers

  Scenario: login and return token
    Given url baseUrl
    And path loginPath
    And request { email: '#(demoEmail)', password: '#(demoPassword)' }
    When method POST
    Then status 200
    And match response.token == '#string'
    And match response.token != ''
    * def authToken = response.token
    * def authHeader = 'Bearer ' + authToken
