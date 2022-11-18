class SalePricesController < ApplicationController
  before_action :set_product
  before_action :set_sale_price, only: [:edit, :update]

  def new
    @sale_price = SalePrice.new
  end

  def create
    @sale_price = SalePrice.new(sale_price_params)
    @sale_price.product = @product

    if @sale_price.save
      redirect_to product_path(@product), notice: "Sale price was successfully created."
    else
     render :new, stutus: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @sale_price.update(sale_price_params)
      redirect_to product_path(@product), notice: "Sale price was successfully created."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_sale_price
    @sale_price = @product.sale_price
  end

  def set_product
    @product = current_company.products.find(params[:product_id])
  end

  def sale_price_params
    params.require(:sale_price).permit(:price)
  end
end
