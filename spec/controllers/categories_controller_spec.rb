require 'spec_helper'

describe CategoriesController do
  describe 'GET show' do
    let(:category) { Fabricate(:category) }
    before do
      post :show, id: category.id
    end
    it "sets the @categories variable" do
      expect(assigns(:categories)).to match_array(Category.all)  #check this
    end
    it "sets the @category variable based on params data" do
      expect(assigns(:category)).to eq(category)
    end
  end
end