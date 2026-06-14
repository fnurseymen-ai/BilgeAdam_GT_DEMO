Feature:Feature başlığı -  Muhasebe Fiş Girişi
Muhasebe Fiş Girişi Senaryoları


Scenario: İleri tarihe muhasebe fişi oluşturulmasının engellenmesi
Given Muhasebe fiş girişi yapmak için yetkisi olan kullanıcı sisteme login olur
And Muhasebe fiş girişi sayfasını açar
When Muhasebe tarihi alanına bugünden "3" gün  ileri bir tarih seçer 
And Fişteki diğer bilgileri girip, onaya gönderir
Then Kullanıcı ekranda "İleri tarihe fiş girişi yapılamaz" mesajını görür
And fiş onaya gönderilmez


 Scenario Outline: İleri tarihe muhasebe fişi oluşturulmasının engellenmesi
    Given Muhasebe fiş girişi yapmak için yetkisi olan kullanıcı sisteme login olur
    And Muhasebe fiş girişi sayfasını açar
    When Muhasebe tarihi alanına bugünden "<gun_sayisi>" gün ileri bir tarih seçer
    And Fişteki diğer bilgileri girip, onaya gönderir
    Then Kullanıcı ekranda "<hata_mesaji>" mesajını görür
    And fiş onaya gönderilmez

    Examples:
      | gun_sayisi | hata_mesaji                    |
      | 3          | İleri tarihe fiş girişi yapılamaz |
      | 7          | İleri tarihe fiş girişi yapılamaz |
      | 15         | İleri tarihe fiş girişi yapılamaz |
      | 30         | İleri tarihe fiş girişi yapılamaz |

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
     When I login with "Valid-user" username and "Valid-pass" password
    Then I should be redirected to the business homepage dashboard


    @debug @smoke
  Scenario: Registration form fill should keep entered values
    Given I open ParaBank registration page
    When I complete business registration with unique user
    Then I should see registration form filled with my generated username
