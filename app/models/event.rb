class Event < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :name, :time, :venue
end