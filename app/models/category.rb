class Category < ActiveRecord::Base
  has_many :events, -> { order("date DESC")}
  
  validates_presence_of :name
end