@javascript
Feature: create a new Document and an automatic new version
  In order to check if a new document has been created
  I should check the title, contents and version

Scenario: Check document creation plus creation of first version
  Given I am authenticated
  And I am on the documents page
    And I follow "Create a Document"
    And I fill in "title" with "A History in future"
    And I fill in "content" with "Future"
    And I press "Create"
    Then I should see "A History in future"
    And I follow "A History in future"
    Then I should see "1"
    And one version should exist automatically