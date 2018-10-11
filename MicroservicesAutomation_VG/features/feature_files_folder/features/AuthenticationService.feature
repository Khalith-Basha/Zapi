Feature: Microservices Authentication Services

#  Background:

@Auth_valid
  Scenario: Authenticate service - Generates the Access token and refresh token
    Given Set basic web application url is "http://34.243.107.163:8080"
    And Set basic user details as "<particular>" and "<value>" below
      | particular | value               |
      | userName   | khalithb@digifit.eu |
      | password   | basha1404           |
    Given Set POST api endpoint as "/auth/login"
    When Set HEADER param request content type as "application/json"
    And Set HEADER param response accept type as "application/json"
    And Set BODY form param using basic user details
#	And Set Query param as "empty"
    When Raise "POST" HTTP request
    Then Valid HTTP response should be received
    And Response http code should be 200
    And Response HEADER content type should be "application/json"
    And Response BODY should not be null or empty
    And Set basic user details as "<particular>" and "<value>" below
      | particular   | value                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
      | status       | OK                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
      | message      | Successful login request from user 'khalithb' with guid: 6870049                                                                                                                                                                                                                                                                                                                                                                                                            |
      | accessToken  | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiZTQ1NGJjNS03NzljLTRiYTMtODkzNy04MDU3OGZiNzYwOWYiLCJpZGVudGl0eSI6eyJ1c2VyX2lkIjoiNjg3MDA0OSIsInVzZXJfY2x1Yl9pZCI6IjEiLCJ1c2VyX21lbWJlcl9pZCI6IjczMzk0MTgiLCJncmFudF90eXBlIjoiYWNjZXNzX3Rva2VuIiwic2NvcGVzIjpbeyJhdXRob3JpdHkiOiJST0xFX1VTRVIifV19LCJzdWIiOiI2ODcwMDQ5IiwiaXNzIjoidmlydHVhZ3ltLmNvbSIsImlhdCI6MTUzOTI1NzAzMywiZXhwIjoxNTM5MjU4ODMzfQ.QRj0wPPT61893siIhalAPwCFsh3J8jkOC529PNnG1VJ5vez9T1kLalp1MNU-dYdAoTEJ2FnfLuXaDsucyHYijQ  |
      | refreshToken | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2OTU0ZjA1NC0wYmU2LTQ0OGQtOGM2Yy04YzAwODM2NTgwYzQiLCJpZGVudGl0eSI6eyJ1c2VyX2lkIjoiNjg3MDA0OSIsInVzZXJfY2x1Yl9pZCI6IjEiLCJ1c2VyX21lbWJlcl9pZCI6IjczMzk0MTgiLCJncmFudF90eXBlIjoicmVmcmVzaF90b2tlbiIsInNjb3BlcyI6W3siYXV0aG9yaXR5IjoiUk9MRV9VU0VSIn1dfSwic3ViIjoiNjg3MDA0OSIsImlzcyI6InZpcnR1YWd5bS5jb20iLCJpYXQiOjE1MzkyNTcwMzMsImV4cCI6MTU3MDc5NzAzM30.bqQNWknevxHZCbTiZtRKooUmRNXFu0BpaZ79NrGXuoql2JMRGHM0n1mgd7BGa-ZsaUsbMtoSop5eqLWxv-Vjcw |
    And Response BODY parsing for "POST" should be successful

  @Auth @Red-209 @Release @Regression
  Scenario: Authenticate service - Invalid credentials
    Given Set basic web application url is "http://34.243.107.163:8080"
    And Set basic user details as "<particular>" and "<value>" below
      | particular | value               |
      | userName   | khalithb@digifit.eu |
      | password   | basha14334          |
    Given Set POST api endpoint as "/auth/login"
    When Set HEADER param request content type as "application/json"
    And Set HEADER param response accept type as "application/json"
    And Set BODY form param using basic user details
#	And Set Query param as "empty"
    When Raise "POST" HTTP request
    Then Valid HTTP response should be received
    And Response http code should be 400
    And Response HEADER content type should be "application/json"
    And Response BODY should not be null or empty
    And Set basic user details as "<particular>" and "<value>" below
      | particular   | value               |
      | status       | ERROR               |
      | message      | Invalid credentials |
      | accessToken  | null                |
      | refreshToken | null                |
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
