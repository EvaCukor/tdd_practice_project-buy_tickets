class Category < ActiveRecord::Base
  has_many :events, -> { order("date ASC")}
  
  validates_presence_of :name
end