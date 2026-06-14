  Feature: Özellik başlığı
#   Kısa açıklama
 
#   Scenario: Senaryonun adı (ne test ediliyor?)
#     Given Ön koşul (başlangıç durumu)
#     When Aksiyon (kullanıcının yaptığı şey)
#     Then Beklenen sonuç (doğrulama)
    @web 
Feature: ParaBank business flows
    Business-like scenarios are kept simple for training and explainability.
    @smoke @happy
  Scenario: Invalid login should show a clear business error
    Given I open ParaBank home page
    When I login with "Invalid-user" username and "Invalid-pass" password
    Then I should see a business login error

  Scenario: Valid login should allow access to the dashboard
    Given I open ParaBank home page
     When I login with valid business credentials
    Then I should be redirected to the business homepage dashboard


    @debug @smoke
  Scenario: Registration form fill should keep entered values
    Given I open ParaBank registration page
    When I complete business registration with unique user
    Then I should see registration form filled with my generated username
