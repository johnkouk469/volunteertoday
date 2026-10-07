# Functional Requirement 3
Feature: View information of organisation or event or user
  As a user
  So that I can be informed about the organisations whose events I apply for and about the events themselves
  I want to be able to view information about the organisation and its events

  Background:
    Given that I am logged in

  Scenario: View information about my events as a user in the homepage
    Given that I am a user
    And that I am viewing the homepage
    When I click on one of the event options in “My Events”
    Then I should be redirected to the event page
    And I should be able to view its information
      | Name              | Spring Hackathon | minimum 3 characters                   |                                        |
      | Location          | Online           |                                        |                                        |
      | Date              | 23-25 of April   |                                        |                                        |
      | Special outfit    | Pajamas          |                                        |                                        |
      | Special Equipment | Internet Access  |                                        |                                        |
      | Status            | in progress      | recruiting or in progress or completed | maximum number of states of an event 1 |

  Scenario: View information about an event as a user in an organisation page
    Given that I am a user
    And I am viewing an organisation page and its events
    Then I should be able to click on an event
    And I should be redirected to the event page
    And I should be able to view its information

  Scenario: View information about an event as a user after a search
    Given that I am a user
    And that I have made a search
    And I am viewing the related results
    When I click on an event from the results
    Then I should be redirected to the event page
    And I am viewing its information

  Scenario: View information about an organisation as a user after a search
    Given that I am a user
    And that I have made a search
    And I am viewing the related results
    When I click on an organisation from the results
    Then I should be redirected to the organisation page
    And I should be able to view its information
      | Name                | Code4Good          | minimum 3 characters |
      | Founded             | 2021               |                      |
      | Field               | Software, Robotics |                      |
      | Accepting Donations | no                 |                      |

  Scenario: View information about a user as an organisation after a search
    Given that I am an organisation
    And that I have made a search
    And I am viewing the related results
    When I click on a user from the results
    Then I should be redirected to the user page
    And I should be able to view their information
      | Name            | Maria Nikolaou                        | minimum 3 characters |                       |
      | Surname         | Nikolaou                              | minimum 3 characters | maximum 99 characters |
      | Age             | 21                                    | maximum of 99        | minimum of 18         |
      | Place of living | Athens                                |                      |                       |
      | Work            | Student                               |                      |                       |
      | Interests       | Fishing, Reading, Environment         |                      |                       |
      | Past Events     | Beach Cleaning Day, Tree Planting Day |                      |                       |
