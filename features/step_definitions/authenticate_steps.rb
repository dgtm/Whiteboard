Given /^I am authenticated$/ do
  User.create!(:username => "b", :password => "123123", :email => "b@a.com")
  visit new_user_session_path
  fill_in("Username", :with => "b")
  fill_in("Password", :with => "123123")
  click_button("Sign in")
end

Given /^I am authenticated as "([^"]*)"$/ do |arg1|
  User.create!(:username => arg1, :password => "123123", :email => arg1+"@a.com")
  visit new_user_session_path
  fill_in("Username", :with => arg1)
  fill_in("Password", :with => "123123")
  click_button("Sign in")
end

Then /^I log out$/ do
  visit destroy_user_session_path
end

Given /^I sleep for (\d+) seconds$/ do |arg1|
  sleep(arg1.to_i)
end
