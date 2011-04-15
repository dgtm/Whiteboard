@culerity
Feature: check a new version
  In order to check if a new version has been created
  I should create a version first

Scenario: Check contents plus creation of a version
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
  And I fill in "version_content" with "Hello master"
  And I press "Update"
  And I sleep for 5 seconds
  Then I should see "Version 2"
  And the contents of version one and two should be different



#
#
# When I edit version 2.1
# Then version 2.2 should remain intact
#
#
# When I create a new version
# the old version should remain intact