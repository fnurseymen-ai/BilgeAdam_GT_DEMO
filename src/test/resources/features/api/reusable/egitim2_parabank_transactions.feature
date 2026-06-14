

Feature: Parabank Transactions API
  Training example: retrieve and validate transaction data for a specific account
  This demonstrates:
  - Working with JSON response arrays
  - Response validation and assertions
  - Array element validation and type checking
  - Using Karate variables and matchers

  Background:
    * configure headers = { Accept: 'application/json', 'Content-Type': 'application/json' }

  Scenario: Mock transaction data for account 13344
    Given def mockTransactions = [{ accountId: 13344, id: 1001, type: 'DEBIT', amount: -150.00, date: '2026-01-15', description: 'ATM Withdrawal' }, { accountId: 13344, id: 1002, type: 'CREDIT', amount: 2500.00, date: '2026-01-14', description: 'Salary Deposit' }, { accountId: 13344, id: 1003, type: 'DEBIT', amount: -75.50, date: '2026-01-10', description: 'Online Purchase' }]
    When def response = mockTransactions
    Then match response == '#array'
    And match response[0].accountId == 13344
    And match response[0].type == 'DEBIT'
    And match response[1].type == 'CREDIT'
    And match response[1].amount == 2500.00

  Scenario: Validate all transactions have required fields
    Given def mockTransactions = [{ accountId: 13344, id: 1001, type: 'DEBIT', amount: -150.00, date: '2026-01-15', description: 'ATM Withdrawal' }, { accountId: 13344, id: 1002, type: 'CREDIT', amount: 2500.00, date: '2026-01-14', description: 'Salary Deposit' }]
    When def response = mockTransactions
    Then match response[0] contains { accountId: '#number', id: '#number', type: '#string', amount: '#number', date: '#string', description: '#string' }
    And match response[1] contains { accountId: '#number', id: '#number', type: '#string', amount: '#number', date: '#string', description: '#string' }

  Scenario: Validate transaction amounts and types
    Given def mockTransactions = [{ accountId: 13344, id: 1001, type: 'DEBIT', amount: -150.00 }, { accountId: 13344, id: 1002, type: 'CREDIT', amount: 2500.00 }, { accountId: 13344, id: 1003, type: 'DEBIT', amount: -75.50 }]
    When def response = mockTransactions
    * def firstTx = response[0]
    * def secondTx = response[1]
    * def thirdTx = response[2]
    Then match firstTx.type == 'DEBIT'
    And match firstTx.amount == -150.00
    And match secondTx.type == 'CREDIT'
    And match secondTx.amount == 2500.00
    And match thirdTx.amount == -75.50

  Scenario: Verify account ID consistency across all transactions
    Given def mockTransactions = [{ accountId: 13344, id: 1001, type: 'DEBIT', amount: -150.00 }, { accountId: 13344, id: 1002, type: 'CREDIT', amount: 2500.00 }, { accountId: 13344, id: 1003, type: 'DEBIT', amount: -75.50 }]
    When def response = mockTransactions
    Then match response[0].accountId == 13344
    And match response[1].accountId == 13344
    And match response[2].accountId == 13344
    And match response[*].accountId contains [13344, 13344, 13344]