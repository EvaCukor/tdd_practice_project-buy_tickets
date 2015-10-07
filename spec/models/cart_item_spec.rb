require 'spec_helper'

describe CartItem do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:event) }
  it { is_expected.to validate_presence_of(:number_of_tickets) }
  it { is_expected.to validate_presence_of(:ticket_type) }
  it { is_expected.to validate_presence_of(:ticket_price) }
  
  describe "#subtotal" do
    it "returns the product of the number of tickets and the ticket price" do
      cart_item = Fabricate(:cart_item)
      expect(cart_item.subtotal).to eq(cart_item.number_of_tickets * cart_item.ticket_price)
    end
  end
end