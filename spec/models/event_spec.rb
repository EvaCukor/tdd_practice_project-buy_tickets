require 'spec_helper'

describe Event do
  it { should belong_to(:category) }
  it { should have_many(:cart_items) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:venue) }
  it { should validate_presence_of(:balcony_ticket_price) }
  it { should validate_presence_of(:floor_ticket_price) }
end