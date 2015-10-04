require 'spec_helper'

feature 'user logs out' do
  scenario 'from events page' do
    alice = Fabricate(:user)
    log_in(alice)
    logout
  end
  
  scenario 'from category page' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    log_in(alice)
    visit category_path(concerts)
    logout
  end
  
  scenario 'from individual event page' do
    alice = Fabricate(:user)
    category = Fabricate(:category)
    event = Fabricate(:event, category: category)
    log_in(alice)
    visit event_path(event)
    logout
  end
  
  scenario 'from the shopping cart' do
    alice = Fabricate(:user)
    log_in(alice)
    click_link "My Shopping Cart"
    logout
  end
end