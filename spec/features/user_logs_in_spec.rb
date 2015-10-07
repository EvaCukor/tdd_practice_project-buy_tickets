require 'spec_helper'

feature 'user signs in' do
  scenario 'with valid user, email and password' do
    alice = Fabricate(:user)
    log_in(alice)
    expect(page).to have_content "My Shopping Cart"
    expect(page).to have_content "Logout"
    expect(page).to have_content alice.name.titleize
    expect(page).to have_no_content "Register"
    expect(page).to have_no_content "Login"
  end
  
  scenario 'with invalid user, email or password' do
    visit login_path
    fill_in "Email", with: "qwertz"
    fill_in "Password", with: "password"
    click_button "Log in"
    expect(page).to have_content "Invalid email or password."
    expect(page).to have_content "Register"
    expect(page).to have_content "Login"
    expect(page).to have_no_content "My Shopping Cart"
  end
end