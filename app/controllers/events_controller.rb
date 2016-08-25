class EventsController < ApplicationController
  def index
    @events = Event.where(status: 0)
  end

  def unavailable
    @events = Event.where(status: 1)
  end

  def show
    @event = Event.find_by_slug(params[:title])
    venue = Venue.find_by_slug(params[:name])
    if @event.nil? || venue.nil?
      render_404
    end
  end
end
