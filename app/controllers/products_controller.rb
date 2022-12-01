class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = current_company.products.ordered
  end

  def show
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    @product.company = current_company
    if @product.save
      respond_to do |format|
        format.html { redirect_to products_path, notice: t('products.created_success') }
        format.turbo_stream { flash.now[:notice] = t('products.created_success') }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: t('products.updated_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path, notice: t('products.destroyed_success') }
      format.turbo_stream { flash.now[:notice] = t('products.destroyed_success') }
    end
  end

  private

  def set_product
    @product = current_company.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :brand,
      :description,
      :unit,
      :size,
      :price,
      :provider_id,
      :initial_quantity,
      :category_id,
      :picture
    )
  end
end
