require 'spec_helper'

describe EventsController do
  describe "GET index" do
    it "sets the @categories variable" do
      category1 = Fabricate(:category)
      category2 = Fabricate(:category)
      get :index
      expect(assigns(:categories)).to match_array([category1, category2])
    end
  end
  
  describe "GET show" do
    let(:event) { Fabricate(:event) }
    before do
      get :show, id: event.id
    end
    it "sets the @event variable based on the params data" do
      expect(assigns(:event)).to eq(event)
    end
    it "renders the event show template" do
      expect(response).to render_template :show
    end
  end
end