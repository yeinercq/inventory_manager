class LocationsController < ApplicationController
  before_action :set_location, only: [ :show, :edit, :update, :destroy ]

  def index
    @locations = current_company.locations
  end

  def show
    @sales = @location.sales.ordered
  end

  def new
    @location = current_company.locations.build
  end

  def create
    @location = current_company.locations.build(location_params)
    if @location.save
      redirect_to locations_path, notice: "Location sucessfuly created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to locations_path, notice: "Location sucessfuly updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @location.destroy
      redirect_to locations_path, notice: "Location sucessfuly destroyed."
    end
  end

  private

  def set_location
    @location = current_company.locations.find( params[:id] )
  end

  def location_params
    params.require(:location).permit(:name, :location_type, :user_id)
  end
end
