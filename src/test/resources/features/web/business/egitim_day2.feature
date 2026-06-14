@web
Feature: ParaBank business registration flows
  @debug @smoke
  Scenario: Registration form fill should keep entered values
    Given I open ParaBank registration page
    When I complete business registration with unique user
    Then I should see registration form filled with my generated username

  @ftmnr
  Scenario: Duplicate isimle kayıt olunca kullanıcı mevcut hata mesajı gösterilmeli
    Given Parabank kayıt sayfasını açtım
    When Ayni kullanıcı adı ile kayıt olmaya çalışıyorum
    Then kullanıcı mevcut hata mesajını görmeliyim    