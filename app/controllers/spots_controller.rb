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
    @spots = Spot.all
  end

  def edit
    @spot = Spot.find(params[:id])
    @areas = Area.all
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      flash[:notice] = "You have updated spot successfully."
      redirect_to spot_path(@spot.id)
    else
      render :edit
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :area_id)
  end
end
