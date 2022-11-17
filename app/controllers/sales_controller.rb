class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy, :trigger]

  def index
    # if params[:status].present?
    #   @status = params[:status]
    #   @sales = current_company.sales.status_value(@status)
    # else
    #   @sales = current_company.sales.ordered
    # end

    # It receives keys->values to filter sale index
    @sales = current_company.sales.where(nil).ordered
    filtering_params(params).each do |key, value|
      @sales = current_company.sales.public_send("filter_by_#{key}", value).ordered if value.present?
    end
  end

  def show
  end

  def new
    @sale = current_user.sales.build
  end

  def create
    if !current_user.sales.empty? and current_user.sales.last.status == "recorded"
      respond_to do |format|
        format.html { redirect_to new_sale_path, notice: "There is a sale with recorded status." }
        format.turbo_stream { flash.now[:nitice] = "There is a sale with recorded status." }
      end
    else
      @sale = current_user.sales.build(sale_params)
      if @sale.save
        respond_to do |format|
          format.html { redirect_to sales_path, notice: "Sale was successfully created." }
          format.turbo_stream { flash.now[:notice] = "Sale was successfully created." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
  end

  def update
    if @sale.update(sale_params)
      respond_to do |format|
        format.html { redirect_to sales_path, notice: "Sale was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Sale was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_path, notice: "Sale was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Sale was successfully destroyed." }
    end
  end

  def trigger
    respond_to do |format|
      if Sales::TriggerEvent.new.call(@sale, params[:event])
        format.html { redirect_to sale_path(@sale), notice: "Invoice status was successfully changed." }
        format.turbo_stream { flash.now[:notice] = "Invoice status was successfully changed." }
      else
        render sale_path(@sale), status: :unprocessable_entity
      end
    end
  end

  private

  def filtering_params(params)
    params.slice(:status, :client, :code)
  end

  def set_sale
    @sale = current_company.sales.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:client_id)
  end
end
