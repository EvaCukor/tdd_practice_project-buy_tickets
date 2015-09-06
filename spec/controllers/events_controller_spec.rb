require 'spec_helper'

describe EventsController do
  describe "GET index" do
    it "sets the @categories variable" do
      get :index
      expect(assigns(:categories)).to match_array(Category.all)
    end
  end
end