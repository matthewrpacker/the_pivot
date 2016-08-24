class VenuesController < ApplicationController
  def index
    @venues = Venue.where(status: 0)
  end

  def show
    @venue = Venue.find_by(slug: params[:name])
    if @venue.nil? || @venue.offline?
      render file: '/public/404', status => 404, :layout => true
    end
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_admin_params)
    if @venue.save
      flash[:success] = "Application submitted! You will hear from us within 3-5 business days."
      redirect_to dashboard_path
    else
      flash.now[:danger] = @venue.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name,
                                  :city,
                                  :state,
                                  :capacity,
                                  :image_path,
                                  :status)
  end

  def venue_admin_params
    params = venue_params
    params[:admin] = current_user
    params
  end
end
