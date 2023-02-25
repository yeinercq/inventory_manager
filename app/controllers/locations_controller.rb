class LocationsController < ApplicationController
  before_action :set_location, only: [ :show, :edit, :update, :destroy ]

  def index
    @locations = current_company.locations
  end

  def show
    if @location.location_type == "compra"
      @coffee_purchases = @location.coffee_purchases.ordered
    elsif @location.location_type == "venta"

      # It receives keys->values to filter sales list
      @sales = @location.sales.where(nil).ordered.first(10)
      filtering_sales_params(params).each do |key, value|
        @sales = @location.sales.public_send("filter_by_#{key}", value).ordered if value.present?
      end
      if params[:start_date].present? and params[:end_date].present?
        @sales =  @location.sales.filter_by_date(
          Date.parse(params[:start_date]).beginning_of_day,
          Date.parse(params[:end_date]).end_of_day
        ).ordered
      end
      # @sales = @location.sales.ordered
    end
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

  def filtering_sales_params(params)
    params.slice(:status, :client_id_number, :code)
  end

  def set_location
    @location = current_company.locations.find( params[:id] )
  end

  def location_params
    params.require(:location).permit(:name, :location_type, :user_id)
  end
end
