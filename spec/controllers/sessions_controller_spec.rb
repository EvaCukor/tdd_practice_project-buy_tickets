require 'spec_helper'

describe SessionsController do
  
  describe "GET new" do
    it "render the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new 
    end
    it "redirects to the root page for authenticated users" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to root_path
    end
  end
  
  describe "POST create" do
    context "with valid credentials" do
      let(:bob) { Fabricate(:user) }
      before do
        post :create, name: bob.name, email: bob.email, password: bob.password
      end
      it "puts the logged-in user in the session" do
        expect(session[:user_id]).to eq(bob.id)
      end
      it "redirects to the root page" do
        expect(response).to redirect_to root_path
      end
    end
    
    context "with invalid credentials" do
      let(:bob) { Fabricate(:user) }
      before do
        post :create, name: bob.name, email: bob.email, password: bob.password + 'qwertz'
      end
      it "does not put the logged-in user in the session" do
        expect(session[:user_id]).to be_nil
      end
      it "sets the error notice" do
        expect(flash[:error]).not_to be_blank
      end
      it_behaves_like "require login"
    end
  end
  
  describe "GET destroy" do
    before do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :destroy
    end
    it "clears the session" do
      expect(session[:user_id]).to be_nil
    end
    it "sets the logout notice" do
      expect(flash[:notice]).not_to be_blank
    end
    it_behaves_like "require login"
  end
  
end