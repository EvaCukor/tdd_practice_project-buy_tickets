require 'spec_helper'

describe Category do
  it { should have_many(:events).order("date ASC") }
  it { should validate_presence_of(:name) }
end