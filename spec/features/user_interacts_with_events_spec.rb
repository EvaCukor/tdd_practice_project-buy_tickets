require 'spec_helper'

feature 'user interacts with events' do
  scenario 'via the events index page' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    event = Fabricate(:event, category: concerts)
    log_in(alice)
    
    expect(page).to have_content event.name
    expect(page).to have_content event.date.strftime("%d %B %Y") + ', ' + event.time.strftime("%H:%M")
    expect(page).to have_content event.venue
    
    click_link "View details"
    
    expect(page).to have_xpath("//h1[contains(., '#{event.name}')]")
    expect(page).to have_content event.date.strftime("%d %B %Y") + ', ' + event.time.strftime("%H:%M")
    expect(page).to have_content event.venue
    expect(page).to have_content event.category.name.capitalize.singularize
  end
  
  scenario 'by choosing a particular category' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    theatre = Fabricate(:category)
    event1 = Fabricate(:event, category: concerts)
    event2 = Fabricate(:event, category: theatre)
    log_in(alice)
    click_link concerts.name.titleize
    expect(page).to have_content event1.name
    expect(page).to have_no_content event2.name
  end
  
  scenario 'with the event already in the shopping cart' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    event = Fabricate(:event, category: concerts)
    cart_item = Fabricate(:cart_item, user: alice, event: event)
    log_in(alice)
    visit event_path(event)
    expect(page).to have_no_content "Add to cart"
  end
  
  scenario 'with the event not yet in the shopping cart' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    event = Fabricate(:event, category: concerts)
    log_in(alice)
    visit event_path(event)
    expect(page).to have_content "Add to cart"
  end
end