# Functional Requirement 1
Feature: Manage personal information
  As a user or organisation
  So that I can manage my account’s personal information
  I want to be able to edit my personal information

  Scenario: Submit information successfully upon signup as a user
    Given that I am a user
    And I have completed my signup
    When I am asked to fill in my information
      | Name            | Maria                         | minimum 3 characters |                       | required     |
      | Surname         | Nikolaou                      | minimum 3 characters | maximum 99 characters | required     |
      | Age             | 21                            | maximum of 99        | minimum of 18         | required     |
      | Place of living | Thessaloniki                  |                      |                       | not required |
      | Work            | Student                       |                      |                       | not required |
      | Interests       | Fishing, Reading, Environment |                      |                       | not required |
      | Past Events     | Sfhmmy12, TedX AUTh           |                      |                       | not required |
    Then I should be able to complete the information asked
    When I click “Submit”
    Then I should view message saying “Information successfully submitted”
    And I should be redirected to my profile page

  Scenario: Submit information successfully upon signup as an organisation
    Given that I am an organisation
    And I have completed my signup
    When I am asked to fill in my information
      | Name                | R4a                         | minimum 3 characters | maximum 99 characters | required     |
      | Founded             | 2021                        |                      | maximum: Today        | not required |
      | Field               | Software, Robotics          |                      |                       | required     |
      | Accepting Donations | no                          |                      |                       | not required |
      | Bank account        | GR1234567891011121314151617 |                      |                       | not required |
    Then I should be able to complete the information asked
    When I click submit
    Then I should view a message saying “Information successfully submitted”
    And I should be redirected to my profile page

  Scenario: Edit information successfully as a user
    Given I am a user
    And I am viewing my profile page
    When I click on the “Manage information” pencil icon
    Then the “Submit Information” prompt card appears
    And I should be able edit the information I want in the respective bars
      | Name            | Maria                         | minimum 3 characters |                       | required     |
      | Surname         | Nikolaou                      | minimum 3 characters | maximum 99 characters | required     |
      | Age             | 21                            | maximum of 99        | minimum of 18         | required     |
      | Place of living | Thessaloniki                  |                      |                       | not required |
      | Work            | Student                       |                      |                       | not required |
      | Interests       | Fishing, Reading, Environment |                      |                       | not required |
      | Past Events     | Sfhmmy12, TedX AUTh           |                      |                       | not required |
      | Add image       | file                          |                      |                       |              |
    When I click on the “Submit Information” button
    Then I should view a message saying "Information successfully submitted."
    And I should be redirected to my profile page

  Scenario: Edit information successfully as an organisation
    Given I am an organisation
    And I am viewing my profile page
    When I click on the “Manage information” pencil icon
    Then the “Submit Information” prompt card appears
    And I should be able to edit the information I want in the respective bars
      | Name                | R4a                         | minimum 3 characters | maximum 99 characters | required     |
      | Founded             | 2021                        |                      | maximum: Today        | not required |
      | Field               | Software, Robotics          |                      |                       | required     |
      | Accepting Donations | no                          |                      |                       | not required |
      | Bank account        | GR1234567891011121314151617 |                      |                       | not required |
      | Add image           | file                        |                      |                       |              |
    When I click on the “Submit Information” button
    Then I should view a message saying "Information successfully submitted."
    And I should be redirected to my profile page

  Scenario: Submit information unsuccessfully
    Given that I am viewing the “Submit Information” prompt card
    Then I should be able to fill in the information in the bars
    When my information violates one or more limitations
    Then I should view the warning message: "Invalid Information" in #ff0000
    And I should be prompted to enter my information again
