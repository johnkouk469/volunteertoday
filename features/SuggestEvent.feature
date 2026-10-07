# Functional Requirement 5
Feature: Suggest event
  As a user
  So that I be informed about new current volunteer events that I might be interested in participating
  I want to be suggested new current volunteer events

  Background:
    Given that I am logged in
    And I am a user

  Scenario Outline: Successful information with event matching and corresponding suggestions
    Given I have submitted my personal information
      | Personal information        | (example)                                                  | minimum value        | maximum value         |
      | Name                        | “Ioannis Papadopoulos”                                     | minimum 3 characters | maximum 30 characters |
      | Age                         | 30                                                         | minimum of 18        | maximum of 99         |
      | Location                    | “Athens”                                                   | minimum 3 characters | maximum 30 characters |
      | Profession                  | “Teacher”                                                  | minimum 3 characters | maximum 30 characters |
      | Interests                   | “Hiking”                                                   | minimum 3 characters | maximum 30 characters |
      | History of volunteer events | “Hellenic Rescue Team Expedition in Olympus (summer 2016)” | minimum 3 characters | maximum 30 characters |
    And I am viewing the homepage
    Then the system should be able to check my personal information
    And the system should match my personal information with current event options
      | Event option | “Tree planting in Chortiatis mountain (spring 2019)” | “First aid workshop” |
    And the system should provide me with some event options based on my information
    When I click on an event option
    Then I should be redirected to the event page

  Scenario: Unavailability of new current event options
    Given I have inserted my personal information
    And I am viewing the homepage
    Then the system should be able to check my personal information
    And my information should be matched to events
    When the matching is not successful
    Then I should view the message “No current events available”
