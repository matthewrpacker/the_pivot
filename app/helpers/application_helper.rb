module ApplicationHelper
  def login_path?
    request.path == login_path
  end

  def platform_admin?
    current_user && current_user.platform_admin?
  end

  def venue_admin?
    current_user && current_user.venue_admin?
  end

  def venue_admin_only?
    current_user && current_user.venue_admin? && !current_user.platform_admin?
  end

  def registered_customer?
    current_user && current_user.registered_customer?
  end

  def venue_exists?
    Venue.where(admin: current_user).exists?
  end
end
