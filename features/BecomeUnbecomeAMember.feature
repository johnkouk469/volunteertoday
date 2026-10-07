# Functional Requirement 6
Feature: Become or Unbecome member of organisation
  As a user
  So that I can be notified about new current volunteer events from a specific organisation
  I want to be able to become a member

  Background:
    Given that I am logged in
    And that I am a user

  Scenario Outline: Become a member successfully
    Given that I am viewing the organisation profile page
    When I click on the “Become A Member” button
    Then I should receive the notification “You are now a member of the organization “<organization name>””
      | Organization name | "Red Cross Greece" |
    And the “Become A Member” button turns into an “Unbecome A Member” button
    When I visit my profile page
    Then I should be able to view the new “<organisation name>” in the “My Organisations” section

  Scenario Outline: Unbecome a member
    Given that I am viewing the organisation page
    When I click on the “Unbecome A Member” button
    Then I should receive the notification “You are not a member of the organization “<organization name>” anymore. You will be missed!”
    And the “Unbecome A Member” button turns into a “Become A Member” button
    When I visit my profile page
    Then I should be able to view that the new “<organisation name>” is removed from the “My Organisations” section
