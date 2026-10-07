# Functional Requirement 2
Feature: Search for an organisation or event or user
  As a user or organisation
  So that I can check the page of a user or organisation or event’s information
  I want to be able to search for user or organisation or event

  Background:
    Given that I am logged in

  Scenario Outline: User/organisation searching
    When I type "<phrase>" in the search bar
      | phrase           | related      |
      | Robotics For All | R4A          |
      | Papado           | Papadopoulos |
    And the search phrase "<phrase>" is entered
    Then results for "<phrase>" are shown
      | Age "21"                   | Maria Nikolaou          |
      | Founded "1999"             | R4A                     |
      | Accepting volunteers "yes" | Greece 2021 Celebration |
    And the related results include "<related>"
    And I should be able to select a search filter
      | Search filter | [“All”, “Events”, “Organisations”, “People” ] |
    When I select a search filter
    Then I should be able to view the filtered results

  Scenario: User/organisation searching failed
    When I type "<phrase>" in the search bar
    And the search phrase "<phrase>" is entered
    But no result matches
    Then I should view a message saying "No results"
    And I should be prompted to enter a new phrase
