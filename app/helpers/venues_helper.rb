module VenuesHelper
  def this_venues_admin?
    Venue.find_by_slug(params[:name]).admin == current_user
  end

  def platform_admin_edit_venue_admin(id)
    User.find(id)
  end

  def proper_role(venue)
    venue.admin == current_user || platform_admin?
  end
end
