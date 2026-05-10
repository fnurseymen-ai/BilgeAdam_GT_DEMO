    @web 
Feature: ParaBank business flows
    Business-like scenarios are kept simple for training and explainability.
    @smoke @happy
  Scenario: Invalid login should show a clear business error
    Given I open ParaBank home page
    And Parabank ana sayfasini actim
    When I login with invalid business credentials
    Then I should see a business login error
    @debug
  Scenario: Registration form fill should keep entered values
    Given I open ParaBank registration page
    When I complete business registration with unique user
    Then I should see registration form filled with my generated username
