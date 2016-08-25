class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_slug(params[:title])
    if @category.nil?
      render_404
    else
      @events = @category.events.where(status: 0)
    end
  end
end
