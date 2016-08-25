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
    @venue.admin.roles << Role.find_by_name("venue_admin")
    flash[:success] = "#{@venue.name} Approved!"
    redirect_to admin_dashboard_index_path
  end

  def destroy
    @venue.destroy
    if from_admin_dash?
      flash[:success] = "#{@venue.name} Declined!"
      redirect_to admin_dashboard_index_path
    else
      flash[:success] = "#{@venue.name} Removed!"
      redirect_to venues_path
    end
  end

  private

  def venue_params
    params.require(:venue).permit(
      :name,
      :city,
      :state,
      :capacity,
      :upload_image
    )
  end

  def set_venue
    @venue = Venue.find_by_slug(params[:name])
  end

  def verify_owner
    unless current_user == @venue.admin || current_user.platform_admin?
      render file: '/public/404', status => 404, layout: true
    end
  end

  def from_admin_dash?
    "/admin/#{request.referrer.split('/').last}" == admin_dashboard_index_path
  end
end
