class SpotsController < ApplicationController
  def new
    @spot = Spot.new
    @areas = Area.all
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      flash[:notice] = "You have created spot successfully."
      redirect_to spot_path(@spot.id)
    else
      render :new
    end
  end

  def index
  end

  def edit
  end

  def show
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :area_id)
  end
end
