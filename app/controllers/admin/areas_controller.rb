class Admin::AreasController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      flash[:notice] = "エリア作成完了！"
      redirect_to admin_areas_path
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
      flash[:notice] = "エリア編集完了！"
      redirect_to admin_areas_path
    else
      render :edit
    end
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end

end
