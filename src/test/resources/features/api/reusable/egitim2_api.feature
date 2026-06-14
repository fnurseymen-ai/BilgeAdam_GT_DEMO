Feature: Parabank Transactions API
  Training example: retrieve transactions for a specific account
  This demonstrates a simple GET request with path parameters and response validation.

  Background:
    * url 'https://parabank.parasoft.com/parabank/services/bank'
    * configure headers = { Accept: 'application/json', 'Content-Type': 'application/json' }
    * def demoUsername = 'john'
    * def demoPassword = 'demo'
    Given path 'login', demoUsername, demoPassword
    When method get
    Then status 200
    * def MusteriNo = response.id
    * print 'MusteriNo:', MusteriNo

  Scenario: Get all transactions for account 13344
    Given path 'accounts/13344/transactions'
    When method get
    Then status 200
    And match response == '#array'
    And match response[0].accountId == 13344
    And match response[0].id == '#number'
    And match response[0].type == '#string'
    And match response[0].amount == '#number'

  Scenario: Verify transaction contains required fields
    Given path 'accounts/13344/transactions'
    When method get
    Then status 200
    * def firstTransaction = response[0]
    And match firstTransaction contains { accountId: '#number', id: '#number', type: '#string', amount: '#number' }
    And match firstTransaction.accountId == 13344


  # Login is performed in Background and `MusteriNo` is available to scenarios

  @tekrun
  Scenario: Customer accounts ile requestleri birbirne bağla
    Given path 'customers', MusteriNo, 'accounts'
    When method get
    Then status 200
    * print "Customer accounts response:", response
    * def accountId = response[0].id
    And match response[0].type =='CHECKING'

  




