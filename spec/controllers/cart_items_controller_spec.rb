require 'spec_helper'

describe CartItemsController, :type => :controller do
  describe "GET index" do
    it "sets @cart_items variable for the logged-in user's cart items" do
      alice = Fabricate(:user)
      set_current_user(alice)
      cart_item1 = Fabricate(:cart_item, user: alice)
      cart_item2 = Fabricate(:cart_item, user: alice)
      get :index
      expect(assigns(:cart_items)).to match_array([cart_item1, cart_item2])
    end
    it "orders the cart items by their ids in ascending order" do
      alice = Fabricate(:user)
      set_current_user(alice)
      cart_item1 = Fabricate(:cart_item, user: alice)
      cart_item2 = Fabricate(:cart_item, user: alice)
      get :index
      expect(CartItem.first).to eq(cart_item1)
    end
    it "redirects to the login page if the user is not logged in" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to login_path
    end
  end
  
  describe "POST create" do
    it "creates a cart item" do
      set_current_user
      event = Fabricate(:event)
      post :create, event_id: event.id
      expect(CartItem.count).to eq(1)
    end
    it "creates a cart item associated with the logged-in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      event = Fabricate(:event)
      post :create, event_id: event.id
      expect(CartItem.first.user).to eq(alice)
    end
    it "creates a cart item associated with the relevant event" do
      set_current_user
      event = Fabricate(:event)
      post :create, event_id: event.id
      expect(CartItem.first.event).to eq(event)
    end
    it "redirects to the shopping cart" do
      set_current_user
      event = Fabricate(:event)
      post :create, event_id: event.id
      expect(response).to redirect_to cart_items_path
    end
    it "does not create a cart item if the event is already in the shopping cart" do
      alice = Fabricate(:user)
      set_current_user(alice)
      ballet = Fabricate(:event)
      Fabricate(:cart_item, user: alice, event: ballet)
      post :create, event_id: ballet.id
      expect(CartItem.count).to eq(1)
    end
    it "redirects to the login page if the user is not logged in" do
      session[:user_id] = nil
      post :create, event_id: 1
      expect(response).to redirect_to login_path
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the item from the shopping cart of the logged-in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      cart_item = Fabricate(:cart_item, user: alice)
      delete :destroy, id: cart_item.id
      expect(CartItem.count).to eq(0)
    end
    it "redirects to the shopping cart page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      cart_item = Fabricate(:cart_item, user: alice)
      delete :destroy, id: cart_item.id
      expect(response).to redirect_to cart_items_path
    end
    it "does not delete the item if it is not in the shopping cart" do
      alice = Fabricate(:user)
      set_current_user(alice)
      cart_item = Fabricate(:cart_item, user: alice)
      delete :destroy, id: cart_item.id
      expect(response).to redirect_to cart_items_path
    end
    it "redirects to the login page if the user is not logged in" do
      delete :destroy, id: 1
      expect(response).to redirect_to login_path
    end
  end
  
  describe "POST update_shopping_cart" do
    it "redirects to the shopping cart page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      cart_item1 = Fabricate(:cart_item)
      cart_item2 = Fabricate(:cart_item)
      post :update_shopping_cart, cart_items: [{id: cart_item1.id, number_of_tickets: 3}, {id: cart_item2.id, ticket_type: "Floor"}]
      expect(response).to redirect_to cart_items_path
    end
    it "redirects to the login page if the user is not logged in" do
      cart_item1 = Fabricate(:cart_item)
      cart_item2 = Fabricate(:cart_item)
      post :update_shopping_cart, cart_items: [{id: cart_item1.id, number_of_tickets: 3}, {id: cart_item2.id, ticket_type: "Floor"}]
      expect(response).to redirect_to login_path
    end
    it "updates the item in the shopping cart of the logged-in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      event1 = Fabricate(:event)
      event2 = Fabricate(:event)
      cart_item1 = Fabricate(:cart_item, user: alice, event: event1)
      cart_item2 = Fabricate(:cart_item, user: alice, event: event2)
      post :update_shopping_cart, commit: "Update", cart_items: [{id: cart_item1.id, number_of_tickets: 4, ticket_type: "Balcony"}, {id: cart_item2.id, number_of_tickets: 2, ticket_type: "Floor"}]
      expect(cart_item1.reload.number_of_tickets).to eq(4)
    end
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