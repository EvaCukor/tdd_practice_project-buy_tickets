class EventsController < ApplicationController
  #before_action :require_user
  
  def index
    @categories = Category.all
  end
  
  def show
    @event = Event.find(params[:id])
  end
end