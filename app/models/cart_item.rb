class CartItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  validates_presence_of :number_of_tickets, :ticket_type, :ticket_price
  
  def subtotal
    number_of_tickets * ticket_price
  end
end