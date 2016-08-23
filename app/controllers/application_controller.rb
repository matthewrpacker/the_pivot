class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user,
                :verify_logged_in,
                :categories,
                :current_admin?,
                :platform_admin?,
                :current_venue_admin
  before_action :set_cart

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def verify_logged_in
    unless current_user
      flash[:danger] = "Please login to view this page"
      redirect_to login_path
    end
  end

  def current_admin?
    current_user && (current_user.venue_admin? || current_user.platform_admin?)
  end

  def platform_admin?
    current_user && current_user.platform_admin?
  end

  def current_venue_admin
    Venue.find_by(admin: current_user) if current_admin?
  end

  def categories
    @categories = Category.all
  end
end
