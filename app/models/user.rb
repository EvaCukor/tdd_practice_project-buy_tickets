class User < ActiveRecord::Base
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  
  has_secure_password
  
  has_many :cart_items
  
  def added_event_to_cart?(event)
    cart_items.map(&:event).include?(event)
  end
end