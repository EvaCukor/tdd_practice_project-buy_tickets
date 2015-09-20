shared_examples "require login" do
  it "redirects to the login page" do
    response.should redirect_to login_path
  end
end