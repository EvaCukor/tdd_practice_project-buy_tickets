require "spec_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#total_price" do
    it "returns the the price of the whole ticket order" do
      cart_item1 = Fabricate(:cart_item, number_of_tickets: 1, ticket_price: 100)
      cart_item2 = Fabricate(:cart_item, number_of_tickets: 2, ticket_price: 150)
      cart_item3 = Fabricate(:cart_item, number_of_tickets: 3, ticket_price: 100)
      expect(total_price([cart_item1, cart_item2, cart_item3])).to eq(700)
    end
  end
end