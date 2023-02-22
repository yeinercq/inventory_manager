class SalesController < ApplicationController
  before_action :set_location
  before_action :set_sale, only: [:show, :edit, :update, :destroy, :trigger]

  # def index
  #   # It receives keys->values to filter sale index
  #   @sales = current_company.sales.where(nil).ordered.first(10)
  #   filtering_params(params).each do |key, value|
  #     @sales = current_company.sales.public_send("filter_by_#{key}", value).ordered if value.present?
  #   end
  #   if params[:start_date].present? and params[:end_date].present?
  #     @sales =  current_company.sales.filter_by_date(Date.parse(params[:start_date]).beginning_of_day, Date.parse(params[:end_date]).end_of_day).ordered
  #   end
  #   # @sales = Sale.filter(filtering_params(params))
  # end

  def show
  end

  def new
    @sale = current_user.sales.build
  end

  def create
    # if !@location.sales.empty? and @location.sales.last.status == "guardada"
    #   respond_to do |format|
    #     format.html { redirect_to new_location_sale_path(@location), notice: t('sales.there_is_a_sale_recorded') }
    #     format.turbo_stream { flash.now[:notice] = t('sales.there_is_a_sale_recorded') }
    #   end
    # else
    @sale = current_user.sales.build(sale_params)
    @sale.location = @location
    if @sale.save
      respond_to do |format|
        format.html { redirect_to location_path(@location), notice: t('sales.created_success') }
        format.turbo_stream { flash.now[:notice] = t("sales.created_success") }
      end
    else
      render :new, status: :unprocessable_entity
    end
    # end
  end

  def edit
  end

  def update
    if @sale.update(sale_params)
      respond_to do |format|
        format.html { redirect_to location_path(@location), notice: t('sales.updated_success') }
        format.turbo_stream { flash.now[:notice] = t('sales.updated_success') }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to location_path(@location), notice: t('sales.destroyed_success') }
      format.turbo_stream { flash.now[:notice] = t('sales.destroyed_success') }
    end
  end

  def trigger
    respond_to do |format|
      if Sales::TriggerEvent.new.call(@sale, params[:event])
        format.html { redirect_to location_sale_path(@location, @sale), notice: t('sales.status_updated') }
        format.turbo_stream { flash.now[:notice] = t('sales.status_updated') }
      else
        render location_sale_path(@location, @sale), status: :unprocessable_entity
      end
    end
  end

  private

  # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params.slice(:status, :client_id_number, :code)
  end

  def set_location
    @location = current_company.locations.find(params[:location_id])
  end

  def set_sale
    @sale = current_company.sales.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:client_id)
  end
end
