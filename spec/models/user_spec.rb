require 'spec_helper'

describe User do
  it { should have_many(:cart_items) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  
  describe "#added_event_to_cart?" do
    let(:user) { Fabricate(:user) }
    let(:event) { Fabricate(:event) }
    it "returns true if current user add the event to the shopping cart" do
      Fabricate(:cart_item, user: user, event: event)
      user.added_event_to_cart?(event).should be true
    end
    it "returns false if the current user didn't add the event to the shopping cart" do
      user.added_event_to_cart?(event).should be false
    end
  end
end