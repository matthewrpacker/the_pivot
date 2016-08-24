class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.roles << Role.find_by_name("registered_customer")
      session[:user_id] = @user.id
      send_welcome_email(@user)
      flash[:success] = "Account created successfully!"
      redirect_to dashboard_path
    else
      flash.now[:danger] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    redirect_to admin_dashboard_index_path if current_user.venue_admin?
  end

  def edit
    if current_user.platform_admin?
      session[:last_url] = request.referrer
    elsif current_user.id.to_s != params[:id]
      render file: '/public/404', status => 404, :layout => true
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Account Updated Successfully!"
      if session[:last_url]
        redirect_to session[:last_url]
      else
        redirect_to dashboard_path
      end
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def send_welcome_email(user)
    UserNotifierMailer.send_signup_email(user).deliver if user.email
  end
end
