require 'spec_helper'

describe User do
  it {should have_many :documents}
  it {should validate_presence_of :username}
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}
end