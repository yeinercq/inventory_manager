class MovementsController < ApplicationController
  before_action :set_product

  def index
    @movements = @product.movements
  end

  def new
    @movement = @product.movements.build
  end

  def create
    @movement = @product.movements.build(movement_params)
    @movement.total = @movement.total_price
    if @movement.save
      redirect_to product_path(@product), notice: "Movement was successfuly created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = current_company.products.find(params[:product_id])
  end

  def movement_params
    params.require(:movement).permit(:mov_type, :mov_sub_type, :quantity, :unit_price)
  end
end
