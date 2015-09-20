class Event < ActiveRecord::Base
  belongs_to :category
  has_many :cart_items
  
  validates_presence_of :name, :date, :time, :venue, :balcony_ticket_price, :floor_ticket_price
end