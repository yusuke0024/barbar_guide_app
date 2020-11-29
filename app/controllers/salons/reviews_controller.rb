class Salons::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @salon = Salon.find(params[:salon_id])
  end

  def create

  end
end
