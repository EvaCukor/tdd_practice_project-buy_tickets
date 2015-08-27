require 'spec_helper'

describe Event do
  it { should belong_to(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:venue) }
end