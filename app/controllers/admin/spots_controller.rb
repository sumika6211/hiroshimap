class Admin::SpotsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      flash[:notice] = "スポット作成完了！"
      redirect_to admin_spots_path
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
      flash[:notice] = "スポット編集完了！"
      redirect_to admin_spots_path
    else
      render :edit
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :area_id, :address, :latitude, :longitude)
  end
end
