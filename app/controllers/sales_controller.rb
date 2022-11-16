class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy, :trigger]

  def index
    @sales = current_user.sales
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

  def set_sale
    @sale = current_user.sales.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:client_id)
  end
end
