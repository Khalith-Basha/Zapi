Feature: Microservices Authentication Services

#  Background:

  @Auth_valid
  Scenario: Authenticate service - Generates the Access token and refresh token
    Given Set basic web application url is "http://34.243.107.163:8080"
    Given Set POST api endpoint as "/auth/login"
    When Set HEADER param request content type as "application/json"
    And Set HEADER param response accept type as "application/json"
    And Set BODY form param using basic user details as "<key>" and "<value>" below
      | key      | value               |
      | username | khalithb@digifit.eu |
      | password | basha1404           |
#	And Set Query param as "empty"
    When Raise "POST" HTTP request
    Then Valid HTTP response should be received
    And Response http code should be 200
    And Response HEADER content type should be "application/json"
    And Response BODY should not be null or empty
    And Set basic user details as "<expectedKey>" and "<expectedValue>" below
      | expectedKey   | expectedValue                                                    |
      | status        | OK                                                               |
      | message       | Successful login request from user 'khalithb' with guid: 6870049 |
      | transactionId | customcheck                                                      |
      | accessToken   | customcheck                                                      |
      | refreshToken  | customcheck                                                      |
    And Response BODY parsing for "POST" should be successful


  @Auth @Red-209 @Release @Regression
  Scenario: Authenticate service - Invalid credentials
    Given Set basic web application url is "http://34.243.107.163:8080"
    Given Set POST api endpoint as "/auth/login"
    When Set HEADER param request content type as "application/json"
    And Set HEADER param response accept type as "application/json"
    And Set BODY form param using basic user details as "<key>" and "<value>" below
      | key      | value               |
      | username | khalithb@digifit.eu |
      | password | basha23232          |
    When Raise "POST" HTTP request
    Then Valid HTTP response should be received
    And Response http code should be 400
    And Response HEADER content type should be "application/json"
    And Response BODY should not be null or empty
    And Set basic user details as "<expectedKey>" and "<expectedValue>" below
      | expectedKey   | expectedValue       |
      | status        | ERROR               |
      | message       | Invalid credentials |
      | accessToken   | null                |
      | refreshToken  | null                |
      | transactionId | customcheck         |
    And Response BODY parsing for "POST" should be successful

#Scenario: POST request example
#  Given Set POST api endpoint as "signup"
# When Set HEADER param request content type as "application/x-www-form-urlencoded"
#	And Set HEADER param response accept type as "application/json"
#	And Set BODY form param using basic user details
#	And Raise "POST" HTTP request
#  Then Valid HTTP response should be received
#	And Response http code should be 201
#	And Response HEADER content type should be "application/json"
#	And Response BODY should not be null or empty
#	And Response BODY parsing for "POST__signup" should be successful
#
#Scenario: PUT request example
#  Given Perform setup for PUT request
# When Set PUT api endpoint as "modify_account_profile_details"
#	And Set HEADER param request content type as "application/x-www-form-urlencoded"
#	And Set HEADER param response accept type as "application/json"
#	And Set BODY form param using basic user details
#	And Modify BODY form param first name as "Jack" and last name as "Wilson"
#	And Raise "PUT" HTTP request
#  Then Valid HTTP response should be received
#	And Response http code should be 200
#	And Response HEADER content type should be "application/json"
#	And Response BODY should not be null or empty
#	And Response BODY parsing for "PUT__modify_account_profile_details" should be successful
#
#Scenario: DELETE request example
#  Given Perform setup for DELETE request
# When Set DELETE api endpoint as "signout"
#	And Set HEADER param request content type as "application/json"
#	And Set HEADER param response accept type as "application/json"
#	And Set Query param as "based on user details"
#	And Raise "DELETE" HTTP request
#  Then Valid HTTP response should be received
#	And Response http code should be 200
#	And Response HEADER content type should be "application/json"
#	And Response BODY should not be null or empty
#	And Response BODY parsing for "DELETE__signout" should be successful
