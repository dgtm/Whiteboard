require 'spec_helper'

describe Version do

  it {should belong_to :document}
  it {should validate_presence_of :content}

end