require 'spec_helper'

describe Event do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:cart_items) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:time) }
  it { is_expected.to validate_presence_of(:venue) }
  it { is_expected.to validate_presence_of(:balcony_ticket_price) }
  it { is_expected.to validate_presence_of(:floor_ticket_price) }
end