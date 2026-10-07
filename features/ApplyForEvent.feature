# Functional Requirement 8
Feature: Become or unbecome a volunteer of a current event
  As a user
  So that I can participate in new current volunteer events or withdraw from events I am already a volunteer of
  I want to be able to become a volunteer of a current volunteer event

  Background:
    Given that I am logged in
    And that I am a user
    And that I am viewing the event page
      | Name              | "Loutraki beach Cleaning Day" |
      | Location          | “Loutraki beach”              |
      | Date              | 30/10/2020                    |
      | Special Outfit    | "not needed"                  |
      | Special Equipment | "not needed"                  |
      | Status            | recruiting                    |

  Scenario Outline: Become a volunteer of a current volunteer event
    Given the event is current
    When I click the “Become a volunteer” button
    Then I should receive the notification “You have successfully become a volunteer for the event “<event name>””.
    And the “Become a volunteer” button turns into a “Unbecome a volunteer” button

  Scenario Outline: Unbecome a volunteer of an event
    Given I have become a volunteer for an event
    When I click the “Unbecome a volunteer” button
    Then I should receive the notification “You have unbecome a volunteer for the event “<event name>”. You will be missed!”
    And the “Unbecome a volunteer” button turns into an “Become a volunteer” button
