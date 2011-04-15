# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

[
{:title => "Conquest of Paradise", shared => false},
{:title => "CSS Designer", shared => true},
{:title => "Android Developer", shared => false},
{:title => "Office Clerk", shared => true}
].each do |attrs|
  document = Document.find_or_create_by_title(attrs)
end
