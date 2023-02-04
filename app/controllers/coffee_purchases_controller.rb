class CoffeePurchasesController < ApplicationController
  before_action :set_coffee_purchase, only: [:show, :edit, :update, :destroy, :trigger]

  def index
    # @coffee_purchases = current_company.coffee_purchases.limit(10).ordered
    @coffee_purchases = current_company.coffee_purchases.where(nil).ordered.first(10)
    filtering_params(params).each do |key, value|
      @coffee_purchases = current_company.coffee_purchases.public_send("filter_by_#{key}", value).ordered if value.present?
    end
    if params[:start_date].present? and params[:end_date].present?
      @coffee_purchases =  current_company.coffee_purchases.filter_by_date(Date.parse(params[:start_date]).beginning_of_day, Date.parse(params[:end_date]).end_of_day).ordered
    end
  end

  def show
  end

  def new
    @coffee_purchase = current_user.coffee_purchases.build
  end

  def create
    @coffee_purchase = current_user.coffee_purchases.build(coffee_purchase_params)
    @coffee_purchase.destare_quantity = current_company.general_setting.destare_quantity
    if @coffee_purchase.save
      respond_to do |format|
        format.html { redirect_to coffee_purchases_path, notice: "Coffee purchase sucessfuly created." }
        format.turbo_stream { flash.now[:notice] = "Coffee purchase sucessfuly created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @coffee_purchase.update(coffee_purchase_params)
      respond_to do |format|
        format.html { redirect_to coffee_purchases_path, notice: "Coffee purchase sucessfuly updated." }
        format.turbo_stream {flash.now[:notice] = "Coffee purchase sucessfuly updated."}
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @coffee_purchase.destroy
      respond_to do |format|
        format.html { redirect_to coffee_purchases_path, notice: "Coffee purchase sucessfuly destroyed." }
        format.turbo_stream { flash.now[:notice] = "Coffee purchase sucessfuly destroyed." }
      end
    end
  end

  def trigger
    respond_to do |format|
      if CoffeePurchases::TriggerEvent.new.call(@coffee_purchase, params[:event])
        format.html { redirect_to coffee_purchase_path(@coffee_purchase), notice: "Status updated"}
        format.turbo_stream { flash.now[:notice] = "Status updated" }
      else
        render coffee_purchase_path(@coffee_purchase), status: :unprocessable_entity
      end
    end
  end

  private

  def filtering_params(params)
    params.slice(:status, :client_id_number, :code, :coffee_type)
  end

  def set_coffee_purchase
    @coffee_purchase = current_company.coffee_purchases.find(params[:id])
  end

  def coffee_purchase_params
    params.require(:coffee_purchase).permit(
      :client_id,
      :coffee_type,
      :quantity,
      :packs_count,
      :decrease_quantity,
      :sieve_quantity,
      :healthy_almond_quantity,
      :pasilla_quantity
    )
  end
end
