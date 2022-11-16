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
    @sales = Sale.where(nil).ordered
    filtering_params(params).each do |key, value|
      @sales = @sales.public_send("filter_by_#{key}", value).ordered if value.present?
    end
  end

  def show
  end

  def new
    @sale = current_user.sales.build
  end

  def create
    @sale = current_user.sales.build(sale_params)
    if @sale.save
      redirect_to sales_path, notice: "Sale was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @sale.update(sale_params)
      redirect_to sales_path, notice: "Sale was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sale.destroy
    redirect_to sales_path, notice: "Sale was successfully destroyed."
  end

  def trigger
      if Sales::TriggerEvent.new.call(@sale, params[:event])
        redirect_to sale_path(@sale), notice: "Invoice status was successfully changed."
      else
        render sale_path(@sale), status: :unprocessable_entity
      end
  end

  private

  def filtering_params(params)
    params.slice(:status, :client, :code)
  end

  def set_sale
    @sale = current_user.sales.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:client_id)
  end
end
