require 'spec_helper'

feature 'user registers' do
  scenario 'with valid name, email and password' do
    visit register_path
    expect(page).to have_content "Register"
    expect(page).to have_content "Login"
    expect(page).to have_no_content "My Shopping Cart"
    fill_in "Your name", with: "Alice"
    fill_in "Email address", with: "alice@mail.com"
    fill_in "Password", with: "password"
    click_button "Register"
    expect(page).to have_xpath("//h1[contains(., 'Login')]")
  end
  
  scenario 'with missing name' do
    visit register_path
    fill_in "Email address", with: "alice@mail.com"
    fill_in "Password", with: "password"
    click_button "Register"
    expect(page).to have_xpath("//span[contains(., \"can't be blank\")]/preceding-sibling::input[@name='user[name]']")
  end
  
  scenario 'with missing email' do
    visit register_path
    fill_in "Your name", with: "Alice"
    fill_in "Password", with: "password"
    click_button "Register"
    expect(page).to have_xpath("//span[contains(., \"can't be blank\")]/preceding-sibling::input[@name='user[email]']")
  end
  
  scenario 'with missing password' do
    visit register_path
    fill_in "Your name", with: "Alice"
    fill_in "Email address", with: "alice@mail.com"
    click_button "Register"
    expect(page).to have_xpath("//span[contains(., \"can't be blank\")]/preceding-sibling::input[@name='user[password]']")
  end
  
  scenario 'with already taken email' do
    bob = Fabricate(:user)
    visit register_path
    fill_in "Your name", with: "Alice"
    fill_in "Email address", with: bob.email
    fill_in "Password", with: "password"
    click_button "Register"
    expect(page).to have_xpath("//span[contains(., 'has already been taken')]/preceding-sibling::input[@name='user[email]']")
  end
end