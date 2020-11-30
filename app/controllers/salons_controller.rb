class SalonsController < ApplicationController
  before_action :redirect_if_yet_logged_in, only: [:new, :create]
  before_action :redirect_if_normal_user, only: [:new, :create]

  def index
    @salons = Salon.all
  end

  def show
    @salon = Salon.find(params[:id])
    @reviews = @salon.reviews
  end

  def new
    @salon = Salon.new
  end

  def create
    @salon = Salon.new(salon_params)
    if @salon.save
      redirect_to new_salon_path
    else
      render :new
    end
  end

  private

  def salon_params
    params.require(:salon).permit(:name, :address)
  end
end
