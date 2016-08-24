class Admin::DashboardController < ApplicationController
  def index
    @venue = Venue.find_by(admin: current_user)
  end
end
