class PermissionsService
  extend Forwardable
  attr_reader :user, :controller, :action

  def_delegators :user,
                 :platform_admin?,
                 :venue_admin?,
                 :registered_customer?

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
    case
    when platform_admin?
      platform_admin_permissions
    when venue_admin?
      venue_admin_permissions
    when registered_customer?
      registered_customer_permissions
    else
      guest_user_permissions
    end
  end

  private

  def platform_admin_permissions
    return true if controller == 'sessions'
    return true if controller == 'admin/dashboard'
    return true if controller == 'admin/events'
    return true if controller == 'admin/venues'
    return true if controller == 'cart'
    return true if controller == 'cart_events'
    return true if controller == 'categories'
    return true if controller == 'charges'
    return true if controller == 'events'
    return true if controller == 'home'
    return true if controller == 'orders'
    return true if controller == 'users'
    return true if controller == 'venues'
  end

  def venue_admin_permissions
    return true if controller == 'sessions'
    return true if controller == 'admin/dashboard'
    return true if controller == 'admin/events'
    return true if controller == 'admin/venues'
    return true if controller == 'cart'
    return true if controller == 'cart_events'
    return true if controller == 'categories'
    return true if controller == 'charges'
    return true if controller == 'events'
    return true if controller == 'home'
    return true if controller == 'orders'
    return true if controller == 'users'
    return true if controller == 'venues'
  end

  def registered_customer_permissions
    return true if controller == 'sessions'
    return true if controller == 'cart'
    return true if controller == 'cart_events'
    return true if controller == 'categories'
    return true if controller == 'charges'
    return true if controller == 'events' && action.in?(%w(index show))
    return true if controller == 'home'
    return true if controller == 'orders'
    return true if controller == 'users'
    return true if controller == 'venues'
  end

  def guest_user_permissions
    return true if controller == 'sessions'
    return true if controller == 'cart'
    return true if controller == 'cart_events'
    return true if controller == 'categories'
    return true if controller == 'events'
    return true if controller == 'home'
    return true if controller == 'users' && action.in?(%w(new create))
    return true if controller == 'venues'
  end
end
