require 'spec_helper'

describe Document do

  it {should have_many :versions}
  it {should validate_presence_of :title}
  # it {should validate_presence_of :content}

end