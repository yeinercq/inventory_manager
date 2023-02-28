class MovementsController < ApplicationController
  require 'pry'

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
      respond_to do |format|
        format.html { redirect_to product_path(@product), notice: t('movements.created_success') }
        format.turbo_stream { flash.now[:notice] = t('movements.created_success') }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def options
    @target = params[:target]
    @options = Movement.mov_types_list[ params[:mov_selected].to_sym ]
    respond_to do |format|
      format.turbo_stream
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
