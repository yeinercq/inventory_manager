class ItemsController < ApplicationController
  before_action :set_sale
  before_action :set_item, only: [:edit, :update, :destroy]

  def new
    @item = @sale.items.build
  end

  def create
    @item = @sale.items.build(item_params)
    @item.unit_price = @item.product.sale_price.price
    if @item.save
      respond_to do |format|
        format.html { redirect_to sale_path(@sale), notice: t('items.created_success') }
        format.turbo_stream { flash.now[:notice] = t('items.created_success') }
      end
      # Updates total attribute to sale
      update_sale_total
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Updates total attribute to sale
    update_sale_total

    if @item.update(item_params)
      respond_to do |format|
        format.html { redirect_to sale_path(@sale), notice: t('items.updated_success') }
        format.turbo_stream { flash.now[:notice] = t('items.updated_success') }
      end
      # Updates total attribute to sale
      update_sale_total
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      respond_to do |format|
        format.html { redirect_to sale_path(@sale), notice: t('items.destroyed_success') }
        format.turbo_stream { flash.now[:notice] = t('items.destroyed_success') }
      end
      # Updates total attribute to sale
      update_sale_total
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def update_sale_total
    # @sale.total = @sale.total_price
    @sale.update(total: @sale.total_price)
  end

  def set_item
    @item = @sale.items.find(params[:id])
  end

  def set_sale
    @sale = current_company.sales.find(params[:sale_id])
  end

  def item_params
    params.require(:item).permit(:product_id, :quantity, :unit_price)
  end
end
