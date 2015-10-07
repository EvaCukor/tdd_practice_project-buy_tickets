def set_current_user(user=nil)
  session[:user_id] ||= (user || Fabricate(:user)).id
end

def log_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit login_path
  page.should have_content "Register"
  page.should have_content "Login"
  page.should_not have_content "My Shopping Cart"
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end

def logout_and_test_login_page
  click_link "Logout"
  expect(page).to have_content "You have logged out."
  expect(page).to have_xpath("//h1[contains(., 'Login')]")
end