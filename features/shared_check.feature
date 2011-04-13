@javascript
Feature: Check that a private document can not be edited
  In order to check if a private document can not be edited
  I should create a document as private, login as another user and check if it can be edited

Scenario: Check for a private document
  Given I am authenticated as "jack"
  And I am on the documents page
    And I follow "Create a Document"
    And I fill in "title" with "A History in future"
    And I fill in "content" with "Future"
    And I press "Create"
    Then I should see "A History in future"
    And I log out
    And I am authenticated as "mack"
    And I am on the documents page
    #And I search for "A History in Future"
    And I follow "A History in future"
    And I follow "Version 1"
    And I fill in "Content" with "Hello master"
    And I press "Update"
    Then I should see "Sorry, this document is only for the private use of the author"
    And a new version should not be created