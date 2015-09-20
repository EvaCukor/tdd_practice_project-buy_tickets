class EventsController < ApplicationController
  def index
    @categories = Category.all
  end
  
  def show
    @event = Event.find(params[:id])
  end
end