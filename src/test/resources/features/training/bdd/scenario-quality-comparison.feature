@training @bdd
Feature: Scenario quality comparison for trainers
  This file intentionally shows the same intent in bad and improved forms.

  Scenario: Poorly written scenario (DO NOT USE)
    Given I do all setup quickly
    When I click many things and wait a bit and continue
    Then it should work somehow

  Scenario: Improved explicit scenario
    Given I am on ParaBank login page
    When I login with invalid credentials
    Then I should see an authentication error message

  Scenario: Same intent without Scenario Outline
    Given I am on ParaBank login page
    When I login with username "invalid-user-1" and password "invalid-pass-1"
    Then I should see an authentication error message
    When I login with username "invalid-user-2" and password "invalid-pass-2"
    Then I should see an authentication error message

  Scenario Outline: Same intent with Scenario Outline (recommended)
    Given I am on ParaBank login page
    When I login with username "<username>" and password "<password>"
    Then I should see an authentication error message

    Examples:
      | username       | password       |
      | invalid-user-1 | invalid-pass-1 |
      | invalid-user-2 | invalid-pass-2 |



#  UYGULAMA ZAMANI


# Bu senaryo doğru şekilde terar yazılacak
Scenario: Login
  Given click login button
  And wait 2 seconds
  And type username
  And type password
  Then homepage appears



  Scenario: Successul login
    Given kullanici login sayfasinda
    When kullanici gecerli bir username ve password ile login olur
    Then kullanici anasayfayi gormelidir


# Aşağıdaki 2 senaryo yerine Scenario Outline kullanılacak
Scenario: invalid user 1
  Given I am on ParaBank login page
  When I login with username "user1" and password "pass1"
  Then I should see an authentication error message

Scenario: invalid user 2
  Given I am on ParaBank login page
  When I login with username "user2" and password "pass2"
  Then I should see an authentication error message

Scenario Outline: Invalid login scenarios
  Given I am on ParaBank login page
  And I change language to Turkish
  When I login with username "<username>" and password "<password>"
  Then I should see an authentication "<hata-mesaji>" error message

  Examples:
    | username | password | hata-mesaji |
    | user1    | pass1    | gecersiz kullanici |
    | user2    | pass2    | hatali sifre |