require 'spec_helper'

describe User do
  it { is_expected.to have_many(:cart_items) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_uniqueness_of(:email) }
  
  describe "#added_event_to_cart?" do
    let(:user) { Fabricate(:user) }
    let(:event) { Fabricate(:event) }
    it "returns true if current user add the event to the shopping cart" do
      Fabricate(:cart_item, user: user, event: event)
      expect(user.added_event_to_cart?(event)).to be true
    end
    it "returns false if the current user didn't add the event to the shopping cart" do
      expect(user.added_event_to_cart?(event)).to be false
    end
  end
end