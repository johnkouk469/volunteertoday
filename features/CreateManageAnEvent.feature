# Functional Requirements 4,7,9
Feature: Create or manage an event
  As an organisation
  So that I can create new events and change their information if needed
  I want to be able to create an event and modify its information

  Background:
    Given that I am logged in
    And that I am an organisation

  Scenario: Create an event
    Given I am in my organisation page
    When I select the option "Create an event"
    Then a new event is created
    And I am asked to submit event information
      | Name                         | Sfhmmy 12       |                                        | minimum 3 characters |
      | Location                     | Online          |                                        |                      |
      | Date                         | 23-25 of April  |                                        |                      |
      | Status                       | in progress     | recruiting or in progress or completed | maximum of 1         |
      | Special Equipment            | [“Yes”, “No”]   |                                        |                      |
      | Add needed special equipment | Internet Access |                                        |                      |
      | Special outfit               | [“Yes”, “No”]   |                                        |                      |
      | Add needed special outfit    | Pajamas         |                                        |                      |
      | Add image                    | file            |                                        |                      |
      | Add description about event  | text            |                                        |                      |
    And I should view a message saying "New event created"
    And a notification should be sent to the members of the organisation
    And I should be redirected to the event page

  Scenario: Edit an event
    Given an event exists
    And I am viewing the event page
    When I select the option "Edit Event"
    Then I should be allowed to edit information
    And I should be allowed to change the status of the event
    And I am asked to submit event information
    When the status is changed to “in progress” or “completed”
    Then the “Become a volunteer” button is disabled
    When I submit the event information
    Then I should view a message saying "Event successfully edited"
    And a notification should be sent to the volunteers of the event
    And I should be redirected to the event page

  Scenario: Unsuccessfully submitting/editing event information
    Given that I am submitting or editing event information
    When My information violates one or more limitations
    Then I should view a message saying "Invalid Information" in #ff0000
    And I should be prompted to enter the event information again

  Scenario: Delete an event
    Given an event exists
    And I am editing the event
    When I select the option "Delete Event"
    Then I should view a message saying "Are you sure you want to delete the event?"
    Then I should be prompted to select "No"
    When I select "Delete"
    Then the event is deleted
    And I should view a message saying "Event is deleted"
    And I should be redirected to the main page
    And a notification should be sent to the volunteers of the event
    When I select "No"
    Then I should be redirected to the event page
