class SalonsController < ApplicationController
  def new
    @salon = Salon.new
  end

  def create
    @salon = Salon.new(salon_params)
    if @salon.save
      
    else
      render :new
    end
  end

  private

  def salon_params
    params.require(:salon).permit(:name, :adress)
  end
end
