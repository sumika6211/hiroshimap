class AreasController < ApplicationController
  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      flash[:notice] = "You have created area successfully."
      redirect_to areas_path
    else
      render :new
    end
  end

  def index
    @areas = Area.all
  end

  def edit
    @area = Area.find(params[:id])
  end

  def update
    @area = Area.find(params[:id])
    if @area.update(area_params)
      flash[:notice] = "You have updated area successfully."
      redirect_to areas_path
    else
      render :edit
    end
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end

end
