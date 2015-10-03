require 'spec_helper'

feature 'user interacts with the shopping cart' do
  scenario 'user adds an event to the shopping cart and then removes it from the cart' do
    alice = Fabricate(:user)
    cat = Fabricate(:category)
    event = Fabricate(:event, category: cat)
    log_in(alice)
    visit event_path(event)
    
    click_link "Add to cart"
    page.should have_content event.name
    page.should have_content event.balcony_ticket_price.to_s
    page.should have_content event.floor_ticket_price.to_s
    
    find("a[href='/cart_items/1']").click
    page.should_not have_content event.name
    page.should have_content "There are currently no items in the shopping cart."
  end
  
  scenario 'user changes number and type of tickets' do
    alice = Fabricate(:user)
    concerts = Fabricate(:category)
    event = Fabricate(:event, category: concerts)
    cart_item = Fabricate(:cart_item, user: alice, event: event)
    log_in(alice)
    visit cart_items_path
    
    check_number_of_tickets(cart_item.number_of_tickets)
    check_ticket_type(cart_item.ticket_type)
    
    within(:xpath, "//tr[contains(.,'#{event.name}')]") do
      find("option[value='3']", visible: false).select_option
    end
    find("input[value='Update']").click
    
    check_number_of_tickets(3)
   check_ticket_type(cart_item.ticket_type)
    
    within(:xpath, "//tr[contains(.,'#{event.name}')]") do
      find("option[value='Balcony']", visible: false).select_option
    end
    find("input[value='Update']").click
    
    check_number_of_tickets(3)
    check_ticket_type("Balcony")
  end
end

def check_number_of_tickets(num)
  expect(find("#cart_items__number_of_tickets").value).to eq(num.to_s)
end

def check_ticket_type(type)
  expect(find("#cart_items__ticket_type").value).to eq(type)
end