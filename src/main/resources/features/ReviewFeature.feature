@EndToEnd
Feature: Automate end to end scenario

  Background: Generate Token
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request
      """
        {
        "username": "supervisor",
        "password": "tek_supervisor"
        }
      """
    When method post
    Then status 200
    And print response
    * def createdToken = response.token

  Scenario: Creating new account, add address, phone and car into it
    Given path "/api/accounts/add-primary-account"
    * def getData = Java.type('tiger.api.fake.data.DataGeneratorReview')
    * def email = getData.getEmail()
    * def name = getData.getName()
    * def lastName = getData.getLastName()
    * def nameTitle = getData.getTitle()
    * def dob = getData.getDob()
    * def phoneNumber = getData.getPhoneNumber()
    And request
      """
      {
      "email": "#(email)",
      "firstName": "#(name)",
      "lastName": "#(lastName)",
      "title": "#(nameTitle)",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "#(dob)",
      "new": true
      }
      """
    And header Authorization = "Bearer " + createdToken
    When method post
    Then status 201
    And print response
    * def dynamicId = response.id
    * def expectedResult = response.email
    Then assert expectedResult == email
    # Adding phone number to account
    And path "/api/accounts/add-account-phone"
    And param primaryPersonId = dynamicId
    And request
      """
        {
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "212",
        "phoneTime": "Morning",
        "phoneType": "Home"
        }
      """
    And header Authorization = "Bearer " + createdToken
    When method post
    Then status 201
    And print response
    # Adding address to the account.
    And path "/api/accounts/add-account-address"
    And param primaryPersonId = dynamicId
    And request
      """
        {
        "id": 0,
        "addressType": "Home",
        "addressLine1": "2598 Arlington Blvd",
        "city": "Arlington",
        "state": "Virginia",
        "postalCode": "56975",
        "countryCode": "88970",
        "current": true
      }
      """
    And header Authorization = "Bearer " + createdToken
    When method post
    Then status 201
    And print response
    #Adding car to account
    And path "/api/accounts/add-account-car"
    And param primaryPersonId = dynamicId
    And request
      """
       {
       "id": 0,
       "make": "Lexus",
       "model": "RX",
       "year": "2022",
       "licensePlate": "VA23"
       }
      """
    And header Authorization = "Bearer " + createdToken
    When method post
    Then status 201
    And print response
