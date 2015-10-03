require 'spec_helper'

feature 'user interacts with events' do
  scenario 'via the events index page' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    event = Fabricate(:event, category: concerts)
    log_in(alice)
    
    page.should have_content event.name
    page.should have_content event.date.strftime("%d %B %Y") + ', ' + event.time.strftime("%H:%M")
    page.should have_content event.venue
    
    click_link "View details"
    
    page.should have_xpath("//h1[contains(., '#{event.name}')]")
    page.should have_content event.date.strftime("%d %B %Y") + ', ' + event.time.strftime("%H:%M")
    page.should have_content event.venue
    page.should have_content event.category.name.capitalize.singularize
  end
  
  scenario 'by choosing a particular category' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    theatre = Fabricate(:category)
    event1 = Fabricate(:event, category: concerts)
    event2 = Fabricate(:event, category: theatre)
    log_in(alice)
    click_link concerts.name.titleize
    page.should have_content event1.name
    page.should_not have_content event2.name
  end
  
  scenario 'with the event already in the shopping cart' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    event = Fabricate(:event, category: concerts)
    cart_item = Fabricate(:cart_item, user: alice, event: event)
    log_in(alice)
    visit event_path(event)
    page.should_not have_content "Add to cart"
  end
  
  scenario 'with the event not yet in the shopping cart' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    event = Fabricate(:event, category: concerts)
    log_in(alice)
    visit event_path(event)
    page.should have_content "Add to cart"
  end
end