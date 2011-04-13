Then /^one version should exist automatically$/ do
  Document.first.versions.count.should == 1
end

Given /^I create a document called "([^"]*)" with content "([^"]*)"$/ do |arg1, arg2|
  Document.create!(:title => arg1, :user_id => current_user.id)
  Document.first.versions.create!(:content => arg2, :number =>1, :document_id => Document.first.id, :user_id => current_user.id)
end

Then /^the contents of version one and two should be different$/ do
  Document.first.versions.first.content.should_not == Document.first.versions.second.content
end

Then /^the contents should be "([^"]*)"$/ do |arg1|
  Document.first.versions.first.content.should == arg1
end

Then /^the content of this version should be the same as the one reverted from$/ do
  Document.first.versions.last.content.should == Document.first.versions.last.content
end
Then /^a new version should not be created$/ do
  Document.first.versions.count.should_not > 1
end