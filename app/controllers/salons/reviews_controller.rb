class Salons::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @salon = Salon.find(params[:salon_id])
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to salon_path(@review.salon)
    else
      render :new
    end
  end

  private

  def review_params
    params.permit(:salon_id, reviews: [:comment]).merge(user_id: current_user.id)
  end
end
