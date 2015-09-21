require 'spec_helper'

describe CategoriesController do
  describe 'GET show' do
    let(:category1) { Fabricate(:category) }
    let(:category2) { Fabricate(:category) }
    before do
      post :show, id: category1.id
    end
    it "sets the @categories variable" do
      expect(assigns(:categories)).to match_array([category1, category2])
    end
    it "sets the @category variable based on params data" do
      expect(assigns(:category)).to eq(category1)
    end
  end
end