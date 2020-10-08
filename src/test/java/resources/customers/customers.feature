Feature: Customers Feature

  Background:
    * def c_name = "hakan"
    * def c_surname = "new2"
    * def customersPostUrl = 'http://localhost:8081/customers?first_name='+c_name+'&last_name='+c_surname
    * def customersPostUrl2 = 'http://localhost:8081/customers'
    * def customersGetUrl = 'http://localhost:8081/customers/'+c_name
    * def customersGetUrl2 = 'http://localhost:8081/customers/gettotest'
    * def customersGetUrl3 = 'http://localhost:8081/customers/'
    * def customersDelUrl = 'http://localhost:8081/customers/'+c_name
    * def customersDelUrl2 = 'http://localhost:8081/customers/'
    * def customersPatchUrl = 'http://localhost:8081/customers/'
    * def utils = Java.type('com.intuit.karate.CommonMethods')
    * def customersGetServiceSchema = {first_name: '#string',last_name: '#string'}
    * def firstNameVal = 'hakan-' + utils.createRandomString(5)
    * def lastNameVal = 'gulcan-' + utils.createRandomString(5)

    * def dummyReq =
    """
    {}
    """

    * def customersRequest =
    """
    {
    "first_name": #(firstNameVal),
    "last_name": #(lastNameVal)
    }
    """


  @customers
  Scenario: Customers Post Req Test
    * configure headers = {Content-Type: application/json}
    Given url customersPostUrl
    And request dummyReq
    When method post
    And print 'Customer Response: ', response

  @customers
  Scenario: Customers Get Req Test And Schema Validation
    * configure headers = {Accept: application/json}
    Given url customersGetUrl2
    And request dummyReq
    When method get
    Then status 200
    And print 'Customers Get Req Response: ', response
    And match response == customersGetServiceSchema
    And print 'Customer First Name: ', response.first_name , ' Customer Last Name: ', response.last_name

  @customers
  Scenario: Customers Del Req Test
    * configure headers = {Accept: application/json}
    Given url customersDelUrl
    And request dummyReq
    When method delete
    Then status 204

  @customers
  Scenario: Customers Patch Req Test
    * configure headers = {Accept: application/json}
    Given url customersPostUrl2
    And request { first_name : "hakanpatch", last_name : "gulcanpatch" }
    When method post
    Then status 201
    Given url customersGetUrl3 + 'hakanpatch'
    When method get
    Then status 200
    * def formerLastName = response.last_name
    Given url customersPatchUrl
    And request { first_name : "hakanpatch", last_name : "new_gulcanpatch" }
    When method patch
    Then status 204
    Given url customersGetUrl3 + 'hakanpatch'
    When method get
    Then status 200
    * def currentLastName = response.last_name
    Then match currentLastName == 'new_gulcanpatch'
    Then match formerLastName != currentLastName

  @customers
  Scenario: Post Status Check - NoMatch
    * configure headers = {Accept: application/json}
    And print 'FirstName: ' , firstNameVal, ' LastName: ', lastNameVal
    Given url customersPostUrl2
    And request customersRequest
    And method post
    Then status 201
    And print response

  @customers
  Scenario: Get Status Check
    * configure headers = {Accept: application/json}
    Given url customersPostUrl2
    And request customersRequest
    And method post
    Then url customersGetUrl3+firstNameVal
    When method get
    Then status 200
    And match response.first_name contains 'hakan-'

  @customers
  Scenario: Del Status Check
    * configure headers = {Accept: application/json}
    Given url customersPostUrl2
    And request customersRequest
    And method post
    Then url customersDelUrl2+firstNameVal
    And method delete
    Then status 204

  @customers
  Scenario: Post Status Check - AlreadyExists
    * configure headers = {Accept: application/json}
    Given url customersPostUrl2
    And request { first_name: 'existtotest', last_name: 'existtotest_' }
    And method post
    Then url customersPostUrl2
    And request { first_name: 'existtotest', last_name: 'existtotest_' }
    And method post
    Then status 409

