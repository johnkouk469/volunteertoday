# Functional Requirement 10
Feature: Donate to organisation
  As a user
  So that I can support an organisation financially
  I want to be able to make a donation

  Background:
    Given that I am logged in
    And I am a user
    And I am viewing the profile of an organisation

  Scenario: Successful donation via credit or debit card
    When I click on “Make a donation” button
    Then I am redirected to the Donation page
    When I insert my name and amount to donate
    And I select “Credit or debit card” on the “Select a payment method” section
    And I insert my credit or debit card information
      | Card number      | 123456789123456 |
      | Card expiry date | 10/25           |
      | Security code    | 789             |
      | ZIP/Postal Code  | 54630           |
    And I check the Terms And Conditions and Privacy Policy agreement box
    And I click on the “Complete Donation” button
    Then I am asked to confirm my donation
    When I click the option “Yes”
    And the electronic payment system accepts the donation
    Then I get a notification about the successful donation

  Scenario: Successful donation via PayPal
    When I click on the “Make a donation” button
    Then I am redirected to the Donation page
    When I insert my name and amount to donate
    And I select “PayPal” on the “Select a payment method” section
    And I insert my PayPal information
      | PayPal email address | donor@example.com |
      | PayPal phone number  | 12345678910       |
    And I check the Terms And Conditions and Privacy Policy agreement box
    And I click on the “Complete Donation” button
    Then I am asked to confirm my donation
    When I click the option “Yes”
    And the electronic payment system accepts the donation
    Then I get a notification about the successful donation

  Scenario: Successful donation via Amazon pay
    When I click on the “Make a donation” button
    Then I am redirected to the Donation page
    When I insert my name and amount to donate
    And I select “Amazon pay” on the “Select a payment method” section
    And I insert my Amazon pay information
      | Amazon pay email address or phone number | donor@example.com                   | 12345678910 |
      | Amazon pay password                      | example-password (****************) | -           |
    And I check the Terms And Conditions and Privacy Policy agreement box
    And I click on the “Complete Donation” button
    Then I am asked to confirm my donation
    When I click the option “Yes”
    And the electronic payment system accepts the donation
    Then I get a notification about the successful donation

  Scenario: Donations via Amazon pay are not supported by the organisation
    Given that the selected organisation does not support Amazon pay
    When I click on the “Make a donation” button
    Then I am redirected to the Donation page
    When I insert my name and amount to donate
    And I select “Amazon pay” on the “Select a payment method” section
    Then I am informed that “Amazon pay is not supported for the selected organisation”
    And the “Complete Donation button” is disabled

  Scenario: Successful donation via Bank Deposit
    When I click on the “Make a donation” button
    Then I am redirected to the Donation page
    When I insert my name and amount to donate
    And I select “Bank Deposit” on the “Select a payment method” section
    And I insert my bank account information
      | IBAN | 12345678910111213141516171819 |
      | PIN  | 1234 (****)                   |
    And I check the Terms And Conditions and Privacy Policy agreement box
    And I click on the “Complete Donation” button
    Then I am asked to confirm my donation
    When I click the option “Yes”
    And the electronic payment system accepts the donation
    Then I get a notification about the successful donation

  Scenario: Unsuccessful donation
    When I click on the “Make a donation” button
    Then I am redirected to the Donation page
    When I insert my name and amount to donate
    And I select an option on the “Select a payment method” section
      | Payment method option | [“Credit or debit card”, “PayPal”,“Amazon pay”, “Bank Deposit”] |
    And I insert the corresponding information
    And I check the Terms And Conditions and Privacy Policy agreement box
    And I click on the “Complete Donation” button
    Then I am asked to confirm my donation
    When I click the option “Yes”
    And the electronic payment system declines the donation
    Then I get a notification about the unsuccessful donation
