module SessionsHelper
  def login_referrer
    session[:previous_url].split('/').last if session[:previous_url]
  end

  def redirect_based_on_referrer
    if login_referrer == 'cart'
      redirect_to cart_index_path
    elsif current_user.venue_admin?
      redirect_to admin_dashboard_index_path
    else
      redirect_to dashboard_path
    end
  end

  def set_user
    if params[:commit]
      @user = User.find_by(username: params[:session][:username])
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])
    end
  end

  def process_local_user
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_based_on_referrer
    else
      flash.now[:danger] = "Login information incorrect."
      render :new
    end
  end

  def process_twitter_user
    session[:user_id] = @user.id
    redirect_based_on_referrer
  end

  def authorize_user
    params[:commit] ? process_local_user : process_twitter_user
  end
end
