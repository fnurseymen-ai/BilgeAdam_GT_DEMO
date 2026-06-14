Feature: Booking Auth API - Token Generation
  Restful-booker authentication service
  Demonstrates login and token retrieval

Background:
    * url 'https://restful-booker.herokuapp.com'
    * configure headers = { Accept: 'application/json', 'Content-Type': 'application/json' }
    * def username = 'admin'
    * def password = 'password123'


@tekrun
@tekrun
Scenario: Token alma
    * def Tokenliste = { username: 'admin', password: 'password123' }
    Given path 'auth'
    And request Tokenliste
    When method post
    Then status 200
    And match response == { token: '#string' }
    * def token = response.token
    * print 'Token sonuc:', token

@tekrun
Scenario: Token ile booking sorgula
    * def Tokenliste = { username: 'admin', password: 'password123' }
    Given path 'auth'
    And request Tokenliste
    When method post
    Then status 200
    * def token = response.token
    * print 'Token sonuc:', token

    * def bookingPayload = { firstname: 'Auto', lastname: 'Test', totalprice: 111, depositpaid: true, bookingdates: { checkin: '2026-06-01', checkout: '2026-06-02' }, additionalneeds: 'Breakfast' }
    Given path 'booking'
    And request bookingPayload
    When method post
    Then status 200
    * def bookingId = response.bookingid
    * print 'Created bookingIdd:', bookingId

    Given path 'booking', bookingId
    And header Cookie = 'token=' + token
    When method get
    Then status 200
    And match response.firstname == bookingPayload.firstname
    And match response.lastname == bookingPayload.lastname


