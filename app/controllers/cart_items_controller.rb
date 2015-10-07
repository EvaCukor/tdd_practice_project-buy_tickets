class CartItemsController < ApplicationController
  before_action :require_user
  
  def index
    @cart_items = current_user.cart_items.order("id asc")
  end
  
  def create
    event = Event.find(params[:event_id])
    add_event_to_cart(event)
    redirect_to cart_items_path
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy if current_user.cart_items.include?(cart_item)
    redirect_to cart_items_path
  end
  
  def update_shopping_cart
    ActiveRecord::Base.transaction do
      if params[:commit] == "Update"
        params[:cart_items].each do |cart_item_data|
          cart_item = CartItem.find(cart_item_data["id"])
          if cart_item.user == current_user
            cart_item.update!(number_of_tickets: cart_item_data["number_of_tickets"], ticket_type: cart_item_data["ticket_type"], ticket_price: define_ticket_price(cart_item, cart_item_data["ticket_type"]))
          end
        end
      end
    end
    redirect_to cart_items_path
  end
  
  private
  
  def add_event_to_cart(event)
    unless current_user.added_event_to_cart?(event)
      CartItem.create(event: event, user: current_user, number_of_tickets: 1, ticket_type: "Balcony", ticket_price: event.balcony_ticket_price)
    end
  end
  
  def define_ticket_price(cart_item, ticket_type)
    if ticket_type == "Balcony"
      cart_item.event.balcony_ticket_price
    elsif ticket_type == "Floor"
      cart_item.event.floor_ticket_price
    end
  end
end