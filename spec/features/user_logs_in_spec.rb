require 'spec_helper'

feature 'user signs in' do
  scenario 'with valid user, email and password' do
    alice = Fabricate(:user)
    log_in(alice)
    page.should have_content "My Shopping Cart"
    page.should have_content "Logout"
    page.should have_content alice.name.titleize
    page.should_not have_content "Register"
    page.should_not have_content "Login"
  end
  
  scenario 'with invalid user, email or password' do
    visit login_path
    fill_in "Email", with: "qwertz"
    fill_in "Password", with: "password"
    click_button "Log in"
    page.should have_content "Invalid email or password."
    page.should have_content "Register"
    page.should have_content "Login"
    page.should_not have_content "My Shopping Cart"
  end
end