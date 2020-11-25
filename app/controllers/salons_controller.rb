class SalonsController < ApplicationController
  def index
    @salons = Salon.all
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
