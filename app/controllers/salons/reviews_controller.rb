class Salons::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @salon = Salon.find(params[:salon_id])
  end

  def create
    @review = Review.new(review_params)
    @review.salon_id = params[:salon_id]
    if @review.save
      redirect_to salon_path(@review.salon)
    else
      @salon = @review.salon
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment).merge(user_id: current_user.id)
  end
end
