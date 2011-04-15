@javascript
Feature: check revert a version
  In order to check if an old version has been reverted to
  I should carry out these tests

Scenario: Check revert functionality plus the content of the created version
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
  And I follow "Revert"
  And I sleep for 5 seconds

  Then I should see "Version 2"
  And the content of this version should be the same as the one reverted from