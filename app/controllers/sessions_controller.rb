class SessionsController < ApplicationController
  include SessionsHelper
  before_action :set_user, only: [:create]

  def new
    redirect_to dashboard_path if current_user
    session[:previous_url] = request.referrer
  end

  def create
    authorize_user
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
