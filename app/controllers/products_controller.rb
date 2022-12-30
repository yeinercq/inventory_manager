class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    # @products = current_company.products.ordered
    @products = Product.filter(filtering_params(params)).filter_by_company_id(current_company.id).ordered
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

  # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params.slice(:name)
  end

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
