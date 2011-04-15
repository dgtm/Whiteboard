
@javascript
Feature: check updates on current version
  In order to check if a the current version has been updated
  I should also check if a new version has not been created

Scenario: Check contents on update of a version if the document is not saved as a new version
  Given I am authenticated
# And I create a document called "Random" with content "Hello"        #HACK:The following steps were written when this step def didnot work

##
  And I am on the documents page
  And I follow "get_started"
  And I fill in "title" with "Random"
  And I fill in "content" with "Hello"
  And I press "Create"
##

  And I am on the documents page
  And I follow "Random"
  And I follow "Version 1"
  And I fill in "Content" with "Hello master"
  And I check "dont_save_as_a_new_version"
  And I press "Update"
  And I sleep for 5 seconds
  Then I should not see "Version 2"
  And I follow "Version 1"
  Then the contents should be "Hello master"