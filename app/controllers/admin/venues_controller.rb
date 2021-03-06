class Admin::VenuesController < ApplicationController
  before_action :set_venue, only: [:edit, :update, :create, :destroy]
  before_action :verify_owner, only: [:edit]

  def edit
  end

  def update
    if @venue.update_attributes(venue_params)
      flash[:success] = "#{@venue.name} Updated Successfully!"
      @venue.update_image_path
      redirect_to venue_path(@venue)
    else
      flash.now[:danger] = @venue.errors.full_messages.join(', ')
      render :edit
    end
  end

  def create
    @venue.update(status: "online")
    @venue.admin.roles << venue_admin
    send_outcome_email(true)
    flash[:success] = "#{@venue.name} Approved!"
    redirect_to admin_dashboard_index_path
  end

  def destroy
    @venue.destroy
    if from_admin_dash?
      send_outcome_email(false)
      flash[:success] = "#{@venue.name} Declined!"
      redirect_to admin_dashboard_index_path
    else
      flash[:success] = "#{@venue.name} Removed!"
      redirect_to venues_path
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name,
                                  :city,
                                  :state,
                                  :capacity,
                                  :upload_image)
  end

  def set_venue
    @venue = Venue.find_by_slug(params[:name])
  end

  def verify_owner
    unless current_user == @venue.admin || current_user.platform_admin?
      render_404
    end
  end

  def from_admin_dash?
    "/admin/#{request.referrer.split('/').last}" == admin_dashboard_index_path
  end

  def send_outcome_email(outcome)
    UserNotifierMailer.send_application_outcome_email(@venue, outcome).deliver
  end
end
