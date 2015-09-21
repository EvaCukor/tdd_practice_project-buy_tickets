require 'spec_helper'

describe CartItemsController, :type => :controller do
  describe "GET index" do
    it_behaves_like "requires login" do
      let(:action) { get :index }
    end
    
    context "with the logged-in user" do
      let(:alice) { Fabricate(:user) }
      let(:event1) { Fabricate(:event) }
      let(:event2) { Fabricate(:event) }
      let(:cart_item1) { Fabricate(:cart_item, user: alice, event: event1) }
      let(:cart_item2) { Fabricate(:cart_item, user: alice, event: event2) }
      before do
        set_current_user(alice)
        get :index
      end
      
      it "sets @cart_items variable for the logged-in user's cart items" do
        expect(assigns(:cart_items)).to match_array([cart_item1, cart_item2])
      end
      it "orders the cart items by their ids in ascending order" do
        # alice = Fabricate(:user)
        # event1 = Fabricate(:event)
        # event2 = Fabricate(:event)
        # cart_item1 = Fabricate(:cart_item, user: alice, event: event1)
        # cart_item2 = Fabricate(:cart_item, user: alice, event: event2)
        # set_current_user(alice)
        # get :index
        expect(assigns(:cart_items).first).to eq(cart_item1)
      end
    end
  end
  
  describe "POST create" do
    it_behaves_like "requires login" do
      let(:action) { post :create, event_id: 1 }
    end
    
    context "with the cart item that is not yet in the shopping cart" do
      let(:alice) { Fabricate(:user) }
      let(:event) { Fabricate(:event) }
      before do
        set_current_user(alice)
        post :create, event_id: event.id
      end
      
      it "creates a cart item" do
        expect(CartItem.count).to eq(1)
      end
      it "creates a cart item associated with the logged-in user" do
        expect(CartItem.first.user).to eq(alice)
      end
      it "creates a cart item associated with the relevant event" do
        expect(CartItem.first.event).to eq(event)
      end
      it "redirects to the shopping cart" do
        expect(response).to redirect_to cart_items_path
      end
    end
    
    context "with the cart item that is already in the shopping cart" do
      it "does not create a cart item" do
        alice = Fabricate(:user)
        set_current_user(alice)
        event = Fabricate(:event)
        Fabricate(:cart_item, user: alice, event: event)
        post :create, event_id: event.id
        expect(CartItem.count).to eq(1)
      end
    end
  end
  
  describe "DELETE destroy" do
    let(:alice) { Fabricate(:user) }
    let(:cart_item) { Fabricate(:cart_item, user: alice) }
    before do
      set_current_user(alice)
      delete :destroy, id: cart_item.id
    end
    it "deletes the item from the shopping cart of the logged-in user" do
      expect(CartItem.count).to eq(0)
    end
    it "redirects to the shopping cart page" do
      expect(response).to redirect_to cart_items_path
    end
    it "does not delete the item if it is not in the shopping cart" do
      expect(response).to redirect_to cart_items_path
    end
    it_behaves_like "requires login" do
      let(:action) { delete :destroy, id: 1 }
    end
  end
  
  describe "POST update_shopping_cart" do
    it_behaves_like "requires login" do
      let(:action) { post :update_shopping_cart, commit: "Update", cart_items: [{id: 1, number_of_tickets: 3, ticket_type: "Balcony"}, {id: 2, number_of_tickets: 1, ticket_type: "Floor"}] }
    end
      
    context "with cart items that belong to the current user" do
      let(:alice) { Fabricate(:user) }
      let(:event1) { Fabricate(:event) }
      let(:event2) { Fabricate(:event) }
      let(:cart_item1) { Fabricate(:cart_item, user: alice, event: event1) }
      let(:cart_item2) { Fabricate(:cart_item, user: alice, event: event2) }
      before { set_current_user(alice) }
      
      it "redirects to the shopping cart page" do
        post :update_shopping_cart, commit: "Update", cart_items: [{id: cart_item1.id, number_of_tickets: 3}, {id: cart_item2.id, ticket_type: "Floor", number_of_tickets: cart_item2.number_of_tickets}]
        expect(response).to redirect_to cart_items_path
      end
      
      it "updates the item in the shopping cart of the logged-in user" do
        post :update_shopping_cart, commit: "Update", cart_items: [{id: cart_item1.id, number_of_tickets: 4, ticket_type: "Balcony"}, {id: cart_item2.id, number_of_tickets: 2, ticket_type: "Floor"}]
        expect(cart_item1.reload.number_of_tickets).to eq(4)
      end
    end
    
    context "with cart items that do not belong to the current user" do
      it "does not update the item if it does not belong to the logged-in user" do
        alice = Fabricate(:user)
        set_current_user(alice)
        bob = Fabricate(:user)
        event1 = Fabricate(:event)
        event2 = Fabricate(:event)
        cart_item1 = Fabricate(:cart_item, user: alice, event: event1)
        cart_item2 = Fabricate(:cart_item, user: bob, event: event2, number_of_tickets: 1)
        post :update_shopping_cart, commit: "Update", cart_items: [{id: cart_item1.id, number_of_tickets: 4, ticket_type: "Balcony"}, {id: cart_item2.id, number_of_tickets: 2, ticket_type: "Floor"}]
        expect(cart_item2.reload.number_of_tickets).to eq(1)
      end
    end
  end
end