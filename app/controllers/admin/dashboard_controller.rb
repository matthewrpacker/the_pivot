class Admin::DashboardController < ApplicationController
  def index
    @venue = Venue.find_by(admin: current_user)
    @venues = Venue.where(status: "offline") if current_user.platform_admin?
  end
end
